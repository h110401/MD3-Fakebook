package service.like;

import model.Like;
import service.Config;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LikeServiceIMPL implements ILikeService {


    private final int SQL_OK = 1;


    @Override
    public List<Like> selectAll() throws SQLException, ClassNotFoundException {
        return null;
    }

    @Override
    public boolean save(Like like) throws SQLException, ClassNotFoundException {
        String SQL_LIKE_POST = "INSERT INTO likepost(idpost,iduser) value (?, ?)";
        String SQL_LIKE_COMMENT = "INSERT INTO likecomment(idcomment,iduser) value (?, ?)";
        int rc;
        try (
                Connection conn = Config.getConnection();
                PreparedStatement psp = conn.prepareStatement(SQL_LIKE_POST);
                PreparedStatement psc = conn.prepareStatement(SQL_LIKE_COMMENT);
        ) {
            if (like.getIdComment() == 0) {
                psp.setInt(1, like.getIdPost());
                psp.setInt(2, like.getIdUser());
                rc = psp.executeUpdate();
            } else {
                // save comment
                psc.setInt(1, like.getIdComment());
                psc.setInt(2, like.getIdUser());
                rc = psc.executeUpdate();
            }
            return rc == SQL_OK;
        }
    }

    @Override
    public Like getById(int id) throws SQLException, ClassNotFoundException {
        return null;
    }

    @Override
    public boolean remove(int id) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    public int checkLikePost(int idPost, int idUser) throws SQLException, ClassNotFoundException {
        String SQL_CHECK_LIKE_POST = "SELECT id from likepost where idpost = ? and iduser = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_CHECK_LIKE_POST);
        ) {
            ps.setInt(1, idPost);
            ps.setInt(2, idUser);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        }
    }

    @Override
    public boolean removeLikePost(int id) throws SQLException, ClassNotFoundException {
        String SQL_REMOVE_LIKE_POST = "DELETE FROM likepost WHERE id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_REMOVE_LIKE_POST);
        ) {
            ps.setInt(1, id);
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public List<Like> findByIdPost(int idPost) throws SQLException, ClassNotFoundException {
        List<Like> likeList = new ArrayList<>();
        String SQL_FIND_LIKE_POST = "select id, iduser from likepost where idpost = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_LIKE_POST);
        ) {
            ps.setInt(1, idPost);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int idUser = rs.getInt(2);
                likeList.add(new Like(id, idPost, 0, idUser));
            }
        }
        return likeList;
    }

    @Override
    public int checkLikeCmt(int idCmt, int idUser) throws SQLException, ClassNotFoundException {
        String SQL_CHECK_LIKE_CMT = "select id from likecomment where idcomment = ? and iduser = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_CHECK_LIKE_CMT);
        ) {
            ps.setInt(1, idCmt);
            ps.setInt(2, idUser);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return -1;
            }
        }
    }

    @Override
    public boolean removeLikeCmt(int id) throws SQLException, ClassNotFoundException {
        String SQL_REMOVE_LIKE_CMT = "delete from likecomment WHERE id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_REMOVE_LIKE_CMT);
        ) {
            ps.setInt(1, id);
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public List<Like> findByIdCmt(int idCmt) throws SQLException, ClassNotFoundException {
        List<Like> likeList = new ArrayList<>();
        String SQL_FIND_LIKE_CMT = "select id,iduser from likecomment where idcomment = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_LIKE_CMT);
        ) {
            ps.setInt(1, idCmt);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int idUser = rs.getInt(2);

                likeList.add(new Like(id, 0, idCmt, idUser));
            }
        }
        return likeList;
    }

}
