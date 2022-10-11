package service.user;

import model.Role;
import model.RoleName;
import model.User;
import service.Config;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class UserServiceIMPL implements IUserService {


    private final int SQL_OK = 1;

    @Override
    public List<User> selectAll() throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<>();
        String SQL_SELECT_ALL = "SELECT id,name,email,password,avatar,status FROM users";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL)
        ) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                String email = rs.getString(3);
                String password = rs.getString(4);
                String avatar = rs.getString(5);
                boolean status = rs.getBoolean(6);
                users.add(new User(id, name, email, password, avatar, status));
            }
        }
        return users;
    }

    @Override
    public boolean save(User user) throws SQLException, ClassNotFoundException {
        String SQL_INSERT = "INSERT INTO users (name,email,password) values (?,?,?)";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);
        ) {
            conn.setAutoCommit(false);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            int rc = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int idUser = 0;
            if (rs.next()) {
                idUser = rs.getInt(1);
            }
            String SQL_INSERT_ROLE = "insert into role_user(id_role,id_user) value (?,?)";
            PreparedStatement ps_role = conn.prepareStatement(SQL_INSERT_ROLE);
            ps_role.setInt(2, idUser);
            for (Role role : user.getRoles()) {
                ps_role.setInt(1, role.getId());
                ps_role.executeUpdate();
            }

            conn.commit();
            return rc == SQL_OK;
        }
    }

    @Override
    public User getById(int id) throws SQLException, ClassNotFoundException {
        String SQL_GET_ID = "SELECT name,email,password,avatar,status FROM users WHERE id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_ID);
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String avatar = rs.getString("avatar");
                boolean status = rs.getBoolean("status");
                User user = new User(id, name, email, password, avatar, status);
                user.setRoles(findRoleByUserId(id));
                return user;
            }
        }
        return null;
    }

    @Override
    public boolean remove(int id) throws SQLException, ClassNotFoundException {
        String SQL_DELETE = "delete from users where id = ?";
        try (
                Connection conn = Config.getConnection();
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
                Connection conn = Config.getConnection();
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
        String SQL_GET_NAME = "SELECT id,name,email,password,avatar,status FROM users where name like ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_NAME);
        ) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String nameF = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String avatar = rs.getString("avatar");
                boolean status = rs.getBoolean("status");
                result.add(new User(id, nameF, email, password, avatar, status));
            }
        }
        return result;
    }

    @Override
    public void update(User user) throws SQLException {
        String SQL_UPDATE = "UPDATE users set name = ?, email = ?, password = ?, avatar = ?,status = ? WHERE id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)
        ) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAvatar());
            ps.setInt(5, user.getId());
            ps.setBoolean(6, user.isStatus());
            ps.executeUpdate();
        }
    }

    @Override
    public Set<Role> findRoleByUserId(int id) {
        Set<Role> roles = new HashSet<>();
        String SQL_FIND = "select id_role, name from role_user ru join role r on ru.id_role = r.id where id_user = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND);
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int idR = rs.getInt(1);
                String name = rs.getString(2);
                roles.add(new Role(idR, RoleName.valueOf(name.toUpperCase())));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return roles;
    }


}
