package cbd.models;

import java.time.Instant;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

public class Video {
    private UUID videoId;
    private String authorUsername;
    private String title;
    private String description;
    private Set<String> tags;
    private Instant uploadTimestamp;

    public Video() {
        this.tags = new HashSet<>();
    }

    public Video(UUID videoId, String authorUsername, String title, String description,
                 Set<String> tags, Instant uploadTimestamp) {
        this.videoId = videoId;
        this.authorUsername = authorUsername;
        this.title = title;
        this.description = description;
        this.tags = tags != null ? tags : new HashSet<>();
        this.uploadTimestamp = uploadTimestamp;
    }

    public UUID getVideoId() {
        return videoId;
    }

    public void setVideoId(UUID videoId) {
        this.videoId = videoId;
    }

    public String getAuthorUsername() {
        return authorUsername;
    }

    public void setAuthorUsername(String authorUsername) {
        this.authorUsername = authorUsername;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Set<String> getTags() {
        return tags;
    }

    public void setTags(Set<String> tags) {
        this.tags = tags != null ? tags : new HashSet<>();
    }

    public Instant getUploadTimestamp() {
        return uploadTimestamp;
    }

    public void setUploadTimestamp(Instant uploadTimestamp) {
        this.uploadTimestamp = uploadTimestamp;
    }

    @Override
    public String toString() {
        return "Video{" +
                "videoId=" + videoId +
                ", authorUsername='" + authorUsername + '\'' +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", tags=" + tags +
                ", uploadTimestamp=" + uploadTimestamp +
                '}';
    }
}

