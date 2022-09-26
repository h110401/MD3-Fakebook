package service.user;

import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserServiceIMPL implements IUserService {

    private final String jdbcUrl = "jdbc:mysql://localhost:3306/fakebook";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "123456";

    private int SQL_OK = 1;

    protected Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
    }

    @Override
    public List<User> selectAll() throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<>();
        String SQL_SELECT_ALL = "SELECT id,name,email,password FROM users";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL)
        ) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                String email = rs.getString(3);
                String password = rs.getString(4);
                users.add(new User(id, name, email, password));
            }
        }
        return users;
    }

    @Override
    public boolean save(User user) throws SQLException, ClassNotFoundException {
        String SQL_INSERT = "INSERT INTO users (name,email,password) values (?,?,?)";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_INSERT);
        ) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public User getById(int id) throws SQLException, ClassNotFoundException {
        String SQL_GET_ID = "SELECT name,email,password FROM users WHERE id = ?";
        try (
                Connection connection = getConnection();
                PreparedStatement ps = connection.prepareStatement(SQL_GET_ID);
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                return new User(id, name, email, password);
            }
        }
        return null;
    }

    @Override
    public boolean remove(int id) throws SQLException, ClassNotFoundException {
        String SQL_DELETE = "delete from users where id = ?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_DELETE);
        ) {
            ps.setInt(1, id);
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public int isAuthenticated(String email, String password) throws SQLException, ClassNotFoundException {
        String SQL_AUTHENTICATE = "SELECT id FROM users WHERE email = ? AND password = ?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_AUTHENTICATE);
        ) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    @Override
    public List<User> findByName(String name) throws SQLException, ClassNotFoundException {
        List<User> result = new ArrayList<>();
        String SQL_GET_NAME = "SELECT id,name,email,password FROM users where name like ?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_NAME);
        ) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String nameF = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");

                result.add(new User(id, nameF, email, password));
            }
        }
        return result;
    }
}
