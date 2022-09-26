package service;

import java.sql.SQLException;
import java.util.List;

public interface IGeneric<T> {
    List<T> selectAll() throws SQLException, ClassNotFoundException;

    boolean save(T t) throws SQLException, ClassNotFoundException;

    T getById(int id) throws SQLException, ClassNotFoundException;

    boolean remove(int id) throws SQLException, ClassNotFoundException;
}
