package service.like;

import model.Like;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;

public interface ILikeService extends IGeneric<Like> {
    int checkLikePost(int idPost, int idUser) throws SQLException, ClassNotFoundException;

    boolean removeLikePost(int id) throws SQLException, ClassNotFoundException;

    List<Like> findByIdPost(int idPost) throws SQLException, ClassNotFoundException;


    int checkLikeCmt(int idCmt, int idUser) throws SQLException, ClassNotFoundException;

    boolean removeLikeCmt(int id) throws SQLException, ClassNotFoundException;

    List<Like> findByIdCmt(int idCmt) throws SQLException, ClassNotFoundException;
}
