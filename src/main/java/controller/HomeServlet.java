package controller;

import model.Post;
import model.User;
import service.friend.FriendServiceIMPL;
import service.friend.IFriendService;
import service.post.IPostService;
import service.post.PostServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    IPostService postService;
    IFriendService friendService;

    @Override
    public void init() throws ServletException {
        postService = new PostServiceIMPL();
        friendService = new FriendServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        try {
            List<Post> postList = postService.selectAll();
            List<User> friendList = friendService.getFriendList(userLogin.getId());
            request.setAttribute("friendList", friendList);
            request.setAttribute("postList", postList);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/home/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
