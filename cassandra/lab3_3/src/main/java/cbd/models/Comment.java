package cbd.models;

import java.util.UUID;

public class Comment {
    private UUID videoId;
    private UUID commentId;
    private String authorUsername;
    private String content;

    public Comment() {
    }

    public Comment(UUID videoId, UUID commentId, String authorUsername, String content) {
        this.videoId = videoId;
        this.commentId = commentId;
        this.authorUsername = authorUsername;
        this.content = content;
    }

    public UUID getVideoId() {
        return videoId;
    }

    public void setVideoId(UUID videoId) {
        this.videoId = videoId;
    }

    public UUID getCommentId() {
        return commentId;
    }

    public void setCommentId(UUID commentId) {
        this.commentId = commentId;
    }

    public String getAuthorUsername() {
        return authorUsername;
    }

    public void setAuthorUsername(String authorUsername) {
        this.authorUsername = authorUsername;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "videoId=" + videoId +
                ", commentId=" + commentId +
                ", authorUsername='" + authorUsername + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}

