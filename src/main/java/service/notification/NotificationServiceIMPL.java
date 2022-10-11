package service.notification;

import model.Notification;
import model.User;
import service.Config;
import service.user.UserServiceIMPL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationServiceIMPL implements INotificationService {

    private final int SQL_OK = 1;


    @Override
    public List<Notification> selectAll() throws SQLException, ClassNotFoundException {
        return null;
    }

    @Override
    public boolean save(Notification notification) throws SQLException, ClassNotFoundException {
        String SQL_SAVE = "INSERT INTO notifications(content,idfrom,idto) value (?,?,?)";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_SAVE);
        ) {
            ps.setString(1, notification.getContent());
            ps.setInt(2, notification.getIdFrom());
            ps.setInt(3, notification.getIdTo());
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public Notification getById(int id) throws SQLException, ClassNotFoundException {
        return null;
    }

    @Override
    public boolean remove(int id) throws SQLException, ClassNotFoundException {
        String SQL_REMOVE = "DELETE FROM notifications WHERE id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_REMOVE);
        ) {
            ps.setInt(1, id);
            int rc = ps.executeUpdate();
            return rc == SQL_OK;
        }
    }

    @Override
    public List<Notification> findByUserId(int idUser) throws SQLException {
        List<Notification> notifications = new ArrayList<>();
        String SQL_FIND_IDUSER = "SELECT id,content,idfrom,created from notifications WHERE idto = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_IDUSER);
        ) {
            ps.setInt(1, idUser);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = Integer.parseInt(rs.getString(1));
                String content = rs.getString(2);
                int idfrom = Integer.parseInt(rs.getString(3));
                String created = rs.getString(4);
                User userFrom = new UserServiceIMPL().getById(idfrom);
                notifications.add(new Notification(id, content, idfrom, idUser, created,userFrom));
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return notifications;
    }
}
