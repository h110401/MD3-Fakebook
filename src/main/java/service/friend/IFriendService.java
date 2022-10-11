package service.friend;

import model.Friend;
import model.FriendStatus;
import model.User;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;

public interface IFriendService extends IGeneric<Friend> {

    Friend findFriendRequest(int iduser1, int iduser2) throws SQLException, ClassNotFoundException;

    FriendStatus getFriendStatus(Friend friend, int idLogin);

    void setStatus(int id, boolean status) throws SQLException, ClassNotFoundException;

    List<User> getFriendList(int idLogin) throws SQLException, ClassNotFoundException;

    List<Friend> findByUserId(int id) throws SQLException, ClassNotFoundException;

    void deleteFriend(int id, int idLogin) throws SQLException, ClassNotFoundException;
}
