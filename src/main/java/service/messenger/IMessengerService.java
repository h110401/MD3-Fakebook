package service.messenger;

import model.ChatBox;
import model.Message;
import model.User;
import service.IGeneric;

import java.sql.SQLException;
import java.util.List;

public interface IMessengerService {
    List<ChatBox> findChatBoxesByUserId(int idUser) throws SQLException;

    List<Message> getMessagesOfChatBox(int idChatBox) throws SQLException;
    List<User> findByChatBoxId(int chatBoxId);

    void save(Message message) throws SQLException;

    int createChatBox(User userLogin, User user) throws SQLException;
}
