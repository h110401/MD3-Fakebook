package service.user;

import model.User;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;

public interface IUserService extends IGeneric<User> {
    int isAuthenticated(String email, String password) throws SQLException, ClassNotFoundException;

    List<User> findByName(String name) throws SQLException, ClassNotFoundException;
}
