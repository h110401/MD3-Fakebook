package model;

public class ChatBox {
    private int id;
    private String name;
    private Message lastMessage;

    private User userChatWith;
    public ChatBox() {
    }

    public ChatBox(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public User getUserChatWith() {
        return userChatWith;
    }

    public void setUserChatWith(User userChatWith) {
        this.userChatWith = userChatWith;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Message getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(Message lastMessage) {
        this.lastMessage = lastMessage;
    }

    @Override
    public String toString() {
        return "ChatBox{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
