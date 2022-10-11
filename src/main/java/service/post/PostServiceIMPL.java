package service.post;

import model.Post;
import model.User;
import service.Config;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static service.Config.getConnection;

public class PostServiceIMPL implements IPostService {

    private final int SQL_OK = 1;

    private final IUserService userService = new UserServiceIMPL();

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
                User user = userService.getById(idUser);
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
                User user = userService.getById(idUser);
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

    @Override
    public List<Post> findByUserId(int idUser) throws SQLException, ClassNotFoundException {
        List<Post> postList = new ArrayList<>();
        String SQL_FIND_USER_ID = "select id,idUser,content,imgUrl,created from posts where idUser = ? order by created desc";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_USER_ID);
        ) {
            ps.setInt(1, idUser);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String content = rs.getString("content");
                String imgUrl = rs.getString("imgUrl");
                String created = rs.getString("created");
                User user = userService.getById(idUser);
                postList.add(new Post(id, user, content, imgUrl, created));
            }
        }
        return postList;
    }
}
