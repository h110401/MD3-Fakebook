package service.comment;

import model.Comment;
import service.Config;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentServiceIMPL implements ICommentService {
    IUserService userService = new UserServiceIMPL();

    @Override
    public List<Comment> selectAll() throws SQLException {
        List<Comment> commentList = new ArrayList<>();
        String SQL_GET_ALL = "select id,idser,idpost,content,created from comments";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL)
        ) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int idUser = rs.getInt(2);
                int idPost = rs.getInt(3);
                String content = rs.getString(4);
                String created = rs.getString(5);
                commentList.add(new Comment(id, idUser, idPost, content, created));
            }
        }
        return commentList;
    }

    @Override
    public boolean save(Comment comment) throws SQLException {
        String SQL_SAVE = "INSERT INTO comments(iduser,idpost,content) VALUES (?,?,?)";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_SAVE);
        ) {
            ps.setInt(1, comment.getIdUser());
            ps.setInt(2, comment.getIdPost());
            ps.setString(3, comment.getContent());

            int rc = ps.executeUpdate();
            return rc == 1;
        }
    }

    @Override
    public Comment getById(int id) throws SQLException {
        String SQL_GET_ID = "SELECT iduser,idpost,content,created FROM comments WHERE id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_ID)
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int idUser = rs.getInt(1);
                int idPost = rs.getInt(2);
                String content = rs.getString(3);
                String created = rs.getString(4);

                return new Comment(id, idUser, idPost, content, created);
            } else {
                return null;
            }
        }
    }

    @Override
    public boolean remove(int id) throws SQLException {
        String SQL_DELETE = "DELETE FROM comments WHERE id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_DELETE);
        ) {
            ps.setInt(1, id);
            int rc = ps.executeUpdate();
            return rc == 1;
        }
    }

    @Override
    public List<Comment> findByIdPost(int idPost) throws SQLException, ClassNotFoundException {
        List<Comment> commentList = new ArrayList<>();
        String SQL_GET_IDPOST = "SELECT id,iduser,idpost,content,created from comments where idpost = ? order by created";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_IDPOST);
        ) {
            ps.setInt(1, idPost);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int iduser = rs.getInt(2);
                int idpost = rs.getInt(3);
                String content = rs.getString(4);
                String created = rs.getString(5);

                Comment comment = new Comment(id, iduser, idpost, content, created);
                comment.setUser(userService.getById(iduser));
                commentList.add(comment);
            }
        }
        return commentList;
    }
}
