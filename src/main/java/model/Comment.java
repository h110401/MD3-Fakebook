package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Comment {
    private int id;
    private int idPost;
    private int idUser;
    private User user;
    private String content;
    private String createdDate;

    public Comment() {
    }

    public Comment(int id, int idPost, int idUser, String content, String createdDate) {
        this.id = id;
        this.idPost = idPost;
        this.idUser = idUser;
        this.content = content;
        this.createdDate = createdDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPost() {
        return idPost;
    }

    public void setIdPost(int idPost) {
        this.idPost = idPost;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getTimePassed() throws ParseException {
        Date from = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(createdDate);
        Date to = new Date();
        long timePassed = to.getTime() - from.getTime();
        int second = (int) (timePassed / 1000) % 60;
        int minute = (int) (timePassed / (1000 * 60) % 60);
        int hour = (int) (timePassed / (1000 * 60 * 60) % 24);
        int day = (int) (timePassed / (1000 * 60 * 60 * 24));
        return (day != 0 ? day + " d" : (hour != 0 ? hour + " h" : (minute != 0 ? minute + " m" : second + " s")));
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", idPost=" + idPost +
                ", idUser=" + idUser +
                ", user=" + user +
                ", content='" + content + '\'' +
                ", createdDate='" + createdDate + '\'' +
                '}';
    }
}
