package controller;

import model.Friend;
import model.FriendStatus;
import model.User;
import service.friend.FriendServiceIMPL;
import service.friend.IFriendService;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "FriendServlet", value = "/friend")
public class FriendServlet extends HttpServlet {
    IFriendService friendService;
    IUserService userService;

    @Override
    public void init() throws ServletException {
        friendService = new FriendServiceIMPL();
        userService = new UserServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        try {
            List<User> friendList = friendService.getFriendList(userLogin.getId());
            request.setAttribute("friendList", friendList);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/friend/friend.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FriendStatus status = FriendStatus.valueOf(request.getParameter("status"));
        String search = request.getParameter("search");
        int iduser = Integer.parseInt(request.getParameter("iduser"));
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        User user;
        Friend friend;
        try {
            user = userService.getById(iduser);
            friend = friendService.findFriendRequest(userLogin.getId(), user.getId());

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        switch (status) {
            case NOT_FRIEND:
                createFriendRequest(userLogin, user);
                break;
            case SENT:
                retrieveFriendRequest(friend.getId());
                break;
            case ACCEPT:
                acceptFriendRequest(friend.getId());
                break;
        }
        response.sendRedirect("/search?search=" + search);
    }

    private void acceptFriendRequest(int id) {
        try {
            friendService.setStatus(id, true);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private void retrieveFriendRequest(int idFriend) {
        try {
            friendService.remove(idFriend);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private void createFriendRequest(User userLogin, User user) {
        try {
            Friend friend = new Friend();
            friend.setUser1(userLogin);
            friend.setUser2(user);
            friend.setStatus(false);

            friendService.save(friend);

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }


}
