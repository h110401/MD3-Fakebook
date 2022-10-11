package controller;

import model.ChatBox;
import model.Friend;
import model.Message;
import model.User;
import service.friend.FriendServiceIMPL;
import service.friend.IFriendService;
import service.messenger.IMessengerService;
import service.messenger.MessengerServiceIMPL;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "MessengerServlet", value = "/messenger")
public class MessengerServlet extends HttpServlet {
    IMessengerService messengerService;
    IFriendService friendService;
    IUserService userService;

    @Override
    public void init() throws ServletException {
        messengerService = new MessengerServiceIMPL();
        friendService = new FriendServiceIMPL();
        userService = new UserServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";
        int idchatbox = 0;
        switch (action) {
            case "create":
                try {
                    User userLogin = (User) request.getSession().getAttribute("userLogin");
                    int idUser = Integer.parseInt(request.getParameter("idUser"));
                    User user = userService.getById(idUser);

                    List<ChatBox> cbList = messengerService.findChatBoxesByUserId(userLogin.getId());

                    for (ChatBox chatBox : cbList) {
                        for (User u : messengerService.findByChatBoxId(chatBox.getId())) {
                            if (user.getId() != userLogin.getId()) {
                                chatBox.setUserChatWith(u);
                            }
                        }
                    }

                    boolean exist = false;
                    for (ChatBox cb : cbList) {
                        if (cb.getUserChatWith().getId() == idUser) {
                            exist = true;
                            idchatbox = -cb.getId();
                            break;
                        }
                    }

                    if (exist) break;

                    idchatbox = messengerService.createChatBox(userLogin, user);

                } catch (SQLException | ClassNotFoundException e) {
                    throw new RuntimeException(e);
                }
                break;
        }
        try {
            User userLogin = (User) request.getSession().getAttribute("userLogin");
            List<ChatBox> chatBoxList = messengerService.findChatBoxesByUserId(userLogin.getId());
            for (ChatBox chatBox : chatBoxList) {
                for (User user : messengerService.findByChatBoxId(chatBox.getId())) {
                    if (user.getId() != userLogin.getId()) {
                        chatBox.setUserChatWith(user);
                    }
                }
            }
            String idStr = request.getParameter("id");
            int id;
            if (chatBoxList.size() > 0) {
                List<Message> messageList;
                if (idStr == null) {
                    id = chatBoxList.get(0).getId();
                } else {
                    id = Integer.parseInt(idStr);
                }
                ChatBox chatBox = null;
                if (idchatbox != 0) {
                    id = idchatbox;
                }

                if (idchatbox < 0) {
                    id = -idchatbox;
                }

                for (ChatBox cb : chatBoxList) {
                    if (cb.getId() == id) {
                        chatBox = cb;
                    }
                }
                messageList = messengerService.getMessagesOfChatBox(id);
                request.setAttribute("selectedChatBox", chatBox);
                request.setAttribute("chatBoxList", chatBoxList);
                if (messageList.size() > 0) {
                    request.setAttribute("messageList", messageList);
                }
            }
            List<User> friendList = friendService.getFriendList(userLogin.getId());
            request.setAttribute("friendList", friendList);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/messenger/messenger.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        int id = Integer.parseInt(request.getParameter("id"));
        String content = request.getParameter("chat");
        if (content != null && !content.trim().isEmpty()) {
            try {
                messengerService.save(new Message(userLogin.getId(), id, content));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        doGet(request, response);
    }
}
