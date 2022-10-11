package model;

public class Like {
    private int id;
    private int idPost;
    private int idComment;
    private int idUser;

    public Like() {
    }

    public Like(int id, int idPost, int idComment, int idUser) {
        this.id = id;
        this.idPost = idPost;
        this.idComment = idComment;
        this.idUser = idUser;
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

    public int getIdComment() {
        return idComment;
    }

    public void setIdComment(int idComment) {
        this.idComment = idComment;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @Override
    public String toString() {
        return "Like{" +
                "id=" + id +
                ", idPost=" + idPost +
                ", idComment=" + idComment +
                ", idUser=" + idUser +
                '}';
    }
}
