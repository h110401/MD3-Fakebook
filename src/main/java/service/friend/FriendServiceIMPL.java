package service.friend;

import model.Friend;
import model.FriendStatus;
import model.User;
import service.Config;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static service.Config.getConnection;

public class FriendServiceIMPL implements IFriendService {

    private final IUserService userService = new UserServiceIMPL();
    private final int SQL_OK = 1;


    @Override
    public List<Friend> selectAll() throws SQLException, ClassNotFoundException {
        List<Friend> friendList = new ArrayList<>();
        String SQL_GET_ALL = "SELECT id,iduser1,iduser2,status FROM friends";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_ALL);
        ) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int iduser1 = rs.getInt("iduser1");
                int iduser2 = rs.getInt("iduser2");
                int status = rs.getInt("status");
                User user1 = userService.getById(iduser1);
                User user2 = userService.getById(iduser2);

                friendList.add(new Friend(id, user1, user2, status == 1));
            }
        }
        return friendList;
    }

    @Override
    public boolean save(Friend friend) throws SQLException, ClassNotFoundException {
        String SQL_SAVE = "INSERT INTO friends(iduser1, iduser2, status) value (?,?,?)";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_SAVE);
        ) {
            ps.setInt(1, friend.getUser1().getId());
            ps.setInt(2, friend.getUser2().getId());
            ps.setInt(3, friend.isStatus() ? 1 : 0);
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public Friend getById(int id) throws SQLException, ClassNotFoundException {
        String SQL_GET_ID = "SELECT iduser1,iduser2,status FROM friends WHERE id=?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_ID);
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int iduser1 = rs.getInt("iduser1");
                int iduser2 = rs.getInt("iduser2");
                User user1 = userService.getById(iduser1);
                User user2 = userService.getById(iduser2);
                int status = rs.getInt("status");
                return new Friend(id, user1, user2, status == 1);
            } else {
                return null;
            }
        }
    }

    @Override
    public boolean remove(int id) throws SQLException, ClassNotFoundException {
        String SQL_REMOVE = "delete from friends where id = ?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_REMOVE)
        ) {
            ps.setInt(1, id);
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public Friend findFriendRequest(int iduser1, int iduser2) throws SQLException, ClassNotFoundException {
        String SQL_FIND_FRIEND = "select id,iduser1,iduser2,status from friends where (iduser1 = ? and iduser2 = ?) or (iduser2 = ? and iduser1 = ?)";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_FRIEND);
        ) {
            ps.setInt(1, iduser1);
            ps.setInt(2, iduser2);
            ps.setInt(3, iduser1);
            ps.setInt(4, iduser2);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                User user1 = userService.getById(rs.getInt(2));
                User user2 = userService.getById(rs.getInt(3));
                int status = rs.getInt(4);

                return new Friend(id, user1, user2, status == 1);
            }
        }
        return null;
    }

    @Override
    public FriendStatus getFriendStatus(Friend friend, int idLogin) {
        if (friend == null) {
            return FriendStatus.NOT_FRIEND;
        } else {
            if (friend.isStatus()) {
                return FriendStatus.FRIEND;
            } else {
                if (friend.getUser1().getId() == idLogin) {
                    return FriendStatus.SENT;
                } else {
                    return FriendStatus.ACCEPT;
                }
            }
        }
    }

    @Override
    public void setStatus(int id, boolean status) throws SQLException, ClassNotFoundException {
        String SQL_STATUS = "update friends set status = ? where id = ?";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_STATUS)
        ) {
            ps.setInt(1, status ? 1 : 0);
            ps.setInt(2, id);
            System.out.println(ps);
            ps.executeUpdate();
        }
    }

    @Override
    public List<User> getFriendList(int idLogin) throws SQLException, ClassNotFoundException {
        List<User> friendList = new ArrayList<>();
        String SQL_GET_FL = "SELECT iduser1,iduser2 from friends where (iduser1=? or iduser2=?) and status = 1";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_GET_FL);
        ) {
            ps.setInt(1, idLogin);
            ps.setInt(2, idLogin);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int iduser1 = rs.getInt("iduser1");
                int iduser2 = rs.getInt("iduser2");

                if (iduser1 == idLogin) {
                    friendList.add(userService.getById(iduser2));
                } else {
                    friendList.add(userService.getById(iduser1));
                }
            }
        }
        return friendList;
    }

    @Override
    public List<Friend> findByUserId(int id) throws SQLException, ClassNotFoundException {
        List<Friend> friendList = new ArrayList<>();
        String SQL_FIND = "SELECT * FROM friends WHERE iduser2 = ? AND status = false";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND);
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int idF = rs.getInt(1);
                int idUser = rs.getInt(2);
                friendList.add(new Friend(idF, userService.getById(idUser), userService.getById(id), false));
            }
        }
        return friendList;
    }

    @Override
    public void deleteFriend(int id, int idLogin) throws SQLException, ClassNotFoundException {
        Friend friend = findFriendRequest(id, idLogin);
        remove(friend.getId());
    }
}
