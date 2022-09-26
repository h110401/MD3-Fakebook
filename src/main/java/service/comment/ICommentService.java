package service.comment;

import model.Comment;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;

public interface ICommentService extends IGeneric<Comment> {
    List<Comment> findByIdPost(int idPost) throws SQLException, ClassNotFoundException;
}
