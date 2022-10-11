package service.post;

import model.Post;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;

public interface IPostService extends IGeneric<Post> {
    List<Post> findByUserId(int idUser) throws SQLException, ClassNotFoundException;
}
