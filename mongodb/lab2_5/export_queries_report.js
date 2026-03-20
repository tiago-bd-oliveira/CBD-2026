const fs = require("fs");
const path = require("path");
const { spawnSync } = require("child_process");

const baseDir = __dirname;
const outputFile = path.join(baseDir, "queries_report.txt");
const dbName = process.argv[2] || "cbd";

const queryFolders = ["find", "aggregate"];

function naturalSort(a, b) {
  return a.localeCompare(b, undefined, { numeric: true, sensitivity: "base" });
}

function getFirstCommentLine(content) {
  const line = content
    .split("\n")
    .map((l) => l.trim())
    .find((l) => l.startsWith("//"));

  return line ? line.replace(/^\/\/\s*/, "") : "No title comment found";
}

function getQueryBody(content) {
  return content
    .split("\n")
    .filter((line) => !line.trim().startsWith("//"))
    .join("\n")
    .trim();
}

function runQueryText(queryBody, db) {
  const script = [
    `db = db.getSiblingDB('${db}');`,
    `const __result = (${queryBody});`,
    `if (__result && typeof __result.toArray === 'function') {`,
    `  printjson(__result.toArray());`,
    `} else {`,
    `  printjson(__result);`,
    `}`,
  ].join("\n");

  const args = ["--quiet", "--eval", script];

  const result = spawnSync("mongosh", args, { encoding: "utf8" });

  if (result.error) {
    return {
      ok: false,
      output: `Failed to run mongosh: ${result.error.message}`,
    };
  }

  if (result.status !== 0) {
    return {
      ok: false,
      output: [result.stdout, result.stderr].filter(Boolean).join("\n").trim(),
    };
  }

  return {
    ok: true,
    output: (result.stdout || "").trim() || "(No output)",
  };
}

function collectQueryFiles() {
  const files = [];

  queryFolders.forEach((folder) => {
    const folderPath = path.join(baseDir, folder);

    if (!fs.existsSync(folderPath)) {
      return;
    }

    fs.readdirSync(folderPath)
      .filter((name) => name.endsWith(".js"))
      .sort(naturalSort)
      .forEach((name) => {
        files.push({
          folder,
          fileName: name,
          filePath: path.join(folderPath, name),
        });
      });
  });

  return files;
}

function main() {
  const queryFiles = collectQueryFiles();

  if (queryFiles.length === 0) {
    console.error("No query files were found in find/ or aggregate/.");
    process.exit(1);
  }

  const report = [];
  report.push(`Mongo Query Report`);
  report.push(`Database: ${dbName}`);
  report.push(`Generated at: ${new Date().toISOString()}`);
  report.push("");

  queryFiles.forEach((file, index) => {
    const content = fs.readFileSync(file.filePath, "utf8");
    const queryTitle = getFirstCommentLine(content);
    const queryBody = getQueryBody(content);
    const execution = runQueryText(queryBody, dbName);

    report.push("=".repeat(90));
    report.push(`Query ${index + 1}: ${file.folder}/${file.fileName}`);
    report.push(`Name: ${queryTitle}`);
    report.push("");
    report.push("Query:");
    report.push(queryBody || "(Empty query)");
    report.push("");
    report.push("Result:");
    report.push(execution.output || "(No output)");
    report.push("");
  });

  fs.writeFileSync(outputFile, report.join("\n"), "utf8");
  console.log(`Report written to: ${outputFile}`);
}

main();
