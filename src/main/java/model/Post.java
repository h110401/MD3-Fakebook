package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Post {

    private int id;
    private User user;
    private String content;
    private String imgUrl;
    private String createdDate;

    public Post() {
    }

    public Post(int id, User user, String content, String imgUrl, String createdDate) {
        this.id = id;
        this.user = user;
        this.content = content;
        this.imgUrl = imgUrl;
        this.createdDate = createdDate;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getImgName() {
        return "userId=" + user.getId() + "-post-" + "'" + createdDate + "'";
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
                ", idUser=" + user +
                ", content='" + content + '\'' +
                ", imgUrl='" + imgUrl + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }

}
