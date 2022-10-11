package service.user;

import model.Role;
import model.User;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;
import java.util.Set;

public interface IUserService extends IGeneric<User> {
    int isAuthenticated(String email, String password) throws SQLException, ClassNotFoundException;

    List<User> findByName(String name) throws SQLException, ClassNotFoundException;

    void update(User user) throws SQLException;

    Set<Role> findRoleByUserId(int id);
}
