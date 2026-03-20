/**
 * Advanced Transformation Script for Genius Hip-Hop Dataset
 * Handles complex escaping, array extraction, and Stanza categorization.
 */

const dbName = "cbd"; // Make sure this matches your DB name
const collectionName = "songs";

const conn = new Mongo();
const db = conn.getDB(dbName);
const collection = db.getCollection(collectionName);

print("--- Starting Transformation for " + collectionName + " ---");

// Grab everything. We will safely skip already-processed files inside the loop.
const cursor = collection.find();

let processedCount = 0;
let skippedCount = 0;

cursor.forEach(function(doc) {
    try {
        // ONLY process if lyrics or features haven't been turned into arrays yet
        if (!Array.isArray(doc.lyrics) || !Array.isArray(doc.features)) {
            
            // --- 1. Fix the Feature Array ---
            // Input example: {"Cam\\\\'ron","Opera Steve"}
            let featureArray = [];
            if (typeof doc.features === "string") {
                // Regex to extract everything inside quotes: "..."
                let matches = [...doc.features.matchAll(/"([^"]+)"/g)];
                if (matches.length > 0) {
                    featureArray = matches.map(m => {
                        // Clean up the weird escaping (e.g. Cam\\\\'ron -> Cam'ron)
                        return m[1].replace(/\\\\'/g, "'").replace(/\\'/g, "'");
                    });
                } else if (doc.features !== "{}" && doc.features.trim() !== "") {
                    // Fallback just in case it's a plain string without quotes
                    featureArray = doc.features.replace(/^{|}$/g, '').split(',').map(s => s.trim());
                }
            } else if (Array.isArray(doc.features)) {
                featureArray = doc.features;
            }

            // --- 2. Fix the Lyrics ---
            // Input example: [Chorus]\nLine 1\nLine 2\n\n[Verse 1]\nLine 3...
            let lyricSections = [];
            if (typeof doc.lyrics === "string") {
                // Split the massive string by blank lines (\n\n)
                let stanzas = doc.lyrics.split(/\n\s*\n/);
                
                lyricSections = stanzas.map((stanza, index) => {
                    let cleanText = stanza.trim();
                    
                    // Extract the tag like [Chorus: ...] or [Verse 1]
                    let sectionType = "Verse"; // Default fallback
                    let tagMatch = cleanText.match(/^\[(.*?)\]/);
                    
                    if (tagMatch) {
                        // If tag is "Chorus: Opera Steve", split by ":" and just keep "Chorus"
                        sectionType = tagMatch[1].split(':')[0].trim(); 
                    } else if (index === 0) {
                        sectionType = "Intro";
                    }

                    // Count the actual sung lines (ignore empty lines and [Tag] lines)
                    let lines = cleanText.split('\n').filter(l => l.trim() !== '' && !l.startsWith('['));

                    return {
                        section_id: index + 1,
                        type: sectionType,
                        line_count: lines.length,
                        content: cleanText
                    };
                });
            } else if (Array.isArray(doc.lyrics)) {
                lyricSections = doc.lyrics;
            }

            // --- 3. Update Database ---
            collection.updateOne(
                { _id: doc._id },
                { 
                    $set: { 
                        features: featureArray,
                        lyrics: lyricSections,
                        processed_at: new Date()
                    }
                }
            );

            processedCount++;
            
            // Print a sample to the console so you know it's working
            if (processedCount === 1 || processedCount % 500 === 0) {
                print("[SUCCESS] Processed: " + doc.title + " by " + doc.artist);
            }

        } else {
            skippedCount++;
        }

    } catch (e) {
        print("[ERROR] Failed to transform " + doc.title + ": " + e.message);
    }
});

print("--- Transformation Complete ---");
print("Successfully processed: " + processedCount);
print("Skipped (already arrays): " + skippedCount);