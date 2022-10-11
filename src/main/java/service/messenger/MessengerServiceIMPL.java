package service.messenger;

import model.ChatBox;
import model.Message;
import model.User;
import service.Config;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static service.Config.getConnection;

public class MessengerServiceIMPL implements IMessengerService {

    private final int SQL_OK = 1;


    @Override
    public List<ChatBox> findChatBoxesByUserId(int idUser) throws SQLException {
        List<ChatBox> chatBoxList = new ArrayList<>();
        String SQL_FIND_CB_USER = "select c.id, c.name, max(if(m.id is null, (select max(id) from message) + 1, m.id)) as `idmes` from chatbox c left join message m on c.id = m.idChatBox join chatboxuser c2 on c.id = c2.idchatbox where c2.iduser = ? group by c.id order by idmes desc";
        try (
                Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_CB_USER)
        ) {
            ps.setInt(1, idUser);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int idChatBox = rs.getInt(1);
                int idLastMessage = rs.getInt(3);
                Message lastMessage = getMessageById(idLastMessage);

                ChatBox chatBox = new ChatBox();
                chatBox.setId(idChatBox);
                chatBox.setName(rs.getString(2));
                chatBox.setLastMessage(lastMessage);
                chatBoxList.add(chatBox);
            }
        }
        return chatBoxList;
    }

    private Message getMessageById(int idMes) {
        String SQL_FIND_MES = "SELECT iduser,idchatbox,content,created from message where id = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_MES);
        ) {
            ps.setInt(1, idMes);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                int iduser = rs.getInt(1);
                int idchatbox = rs.getInt(2);
                String content = rs.getString(3);
                String created = rs.getString(4);

                return new Message(idMes, iduser, idchatbox, content, created);
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Message> getMessagesOfChatBox(int idChatBox) throws SQLException {
        List<Message> messageList = new ArrayList<>();
        String SQL_FIND_MES = "select id,iduser,content,created from message where idChatBox = ? order by created";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_FIND_MES);
        ) {
            ps.setInt(1, idChatBox);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                int idUser = rs.getInt(2);
                String content = rs.getString(3);
                String created = rs.getString(4);
                messageList.add(new Message(id, idUser, idChatBox, content, created));
            }
        }
        return messageList;
    }

    public List<User> findByChatBoxId(int chatBoxId) {
        IUserService userService = new UserServiceIMPL();
        List<User> users = new ArrayList<>();
        String SQL = "select iduser from chatboxuser where idchatbox = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL);
        ) {
            ps.setInt(1, chatBoxId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                users.add(userService.getById(id));
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return users;
    }

    @Override
    public void save(Message message) throws SQLException {
        String SQL_SAVE = "insert into message(iduser,idchatbox,content) value (?,?,?)";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_SAVE);
        ) {
            ps.setInt(1, message.getIdUser());
            ps.setInt(2, message.getIdChatBox());
            ps.setString(3, message.getContent());
            ps.executeUpdate();
        }
    }

    @Override
    public int createChatBox(User userLogin, User user) throws SQLException {
        String SQL_CREATE = "insert into chatbox(name) value (?)";
        String SQL_INSERT = "insert into chatboxuser(idchatbox,iduser) value (?,?)";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL_CREATE, Statement.RETURN_GENERATED_KEYS);
                PreparedStatement ps1 = conn.prepareStatement(SQL_INSERT);
        ) {
            conn.setAutoCommit(false);
            ps.setString(1, user.getName());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int idchatbox = 0;
            if (rs.next()) {
                idchatbox = rs.getInt(1);
            }
            ps1.setInt(1, idchatbox);
            ps1.setInt(2, userLogin.getId());
            ps1.executeUpdate();
            ps1.setInt(2, user.getId());
            ps1.executeUpdate();

            conn.commit();

            return idchatbox;
        }
    }

}
