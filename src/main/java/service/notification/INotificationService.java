package service.notification;

import model.Notification;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;

public interface INotificationService extends IGeneric<Notification> {
    List<Notification> findByUserId(int idUser) throws SQLException;
}
