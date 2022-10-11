package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Message {
    private int id;
    private int idUser;
    private int idChatBox;

    private String content;
    private String created;

    private User user;

    public Message() {
    }

    public Message(int id, int idUser, int idChatBox, String content, String created) {
        this.id = id;
        this.idUser = idUser;
        this.idChatBox = idChatBox;
        this.content = content;
        this.created = created;
    }

    public Message(int idUser, int idChatBox, String content) {
        this.idUser = idUser;
        this.idChatBox = idChatBox;
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdChatBox() {
        return idChatBox;
    }

    public void setIdChatBox(int idChatBox) {
        this.idChatBox = idChatBox;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getTimePassed() throws ParseException {
        Date from = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(created);
        Date to = new Date();
        long timePassed = to.getTime() - from.getTime();
        int second = (int) (timePassed / 1000) % 60;
        int minute = (int) (timePassed / (1000 * 60) % 60);
        int hour = (int) (timePassed / (1000 * 60 * 60) % 24);
        int day = (int) (timePassed / (1000 * 60 * 60 * 24));
        return (day != 0 ? day + "d" : (hour != 0 ? hour + "h" : (minute != 0 ? minute + "m" : second + "s")));
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", idUser=" + idUser +
                ", idChatBox=" + idChatBox +
                ", created='" + created + '\'' +
                '}';
    }
}
