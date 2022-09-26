package service.post;

import model.Post;
import model.User;
import service.user.UserServiceIMPL;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PostServiceIMPL implements IPostService {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/fakebook";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "123456";

    private final int SQL_OK = 1;

    protected Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    public List<Post> selectAll() throws SQLException, ClassNotFoundException {
        List<Post> postList = new ArrayList<>();
        String SQL_GET_ALL = "SELECT id,idUser,content,imgUrl,created FROM posts order by created DESC";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
        ) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int idUser = rs.getInt("idUser");
                User user = new UserServiceIMPL().getById(idUser);
                String content = rs.getString("content");

                String imgUrl = rs.getString("imgUrl");

                String created = rs.getString("created");

                Post post = new Post(id, user, content, imgUrl, created);

                postList.add(post);
            }
        }
        return postList;
    }

    @Override
    public boolean save(Post post) throws SQLException, ClassNotFoundException {
        String SQL_INSERT = "INSERT INTO posts(idUser,content,imgUrl,created) value (?,?,?,?)";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_INSERT);
        ) {
            ps.setInt(1, post.getUser().getId());
            ps.setString(2, post.getContent());
            ps.setString(3, post.getImgUrl());
            ps.setString(4, post.getCreatedDate());
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public Post getById(int id) throws SQLException, ClassNotFoundException {
        String SQL_INSERT = "select id,idUser,content,imgUrl,created from posts where id = ?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_INSERT);
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int idPost = rs.getInt("id");
                int idUser = rs.getInt("idUser");
                User user = new UserServiceIMPL().getById(idUser);
                String content = rs.getString("content");
                String imgUrl = rs.getString("imgUrl");
                String created = rs.getString("created");

                return new Post(idPost, user, content, imgUrl, created);
            } else {
                return null;
            }
        }
    }

    @Override
    public boolean remove(int id) throws SQLException, ClassNotFoundException {
        String SQL_INSERT = "delete from posts where id = ?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_INSERT);
        ) {
            ps.setInt(1, id);
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

}
