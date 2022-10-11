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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchServlet", value = "/search")
public class SearchServlet extends HttpServlet {
    IUserService userService;
    IFriendService friendService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceIMPL();
        friendService = new FriendServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        request.setAttribute("search", search);
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        List<User> userList;
        try {
            userList = userService.findByName(search);
            for (User user : userList) {
                if (user.getId() == userLogin.getId()) {
                    userList.remove(user);
                    break;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        Map<Integer, FriendStatus> relative = new HashMap<>();
        try {
            for (User user : userList) {
                Friend friend = friendService.findFriendRequest(userLogin.getId(), user.getId());
                relative.put(user.getId(), friendService.getFriendStatus(friend,userLogin.getId()));
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        request.setAttribute("relativeMap", relative);
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("/search/search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
