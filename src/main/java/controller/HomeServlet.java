package controller;

import model.Friend;
import model.Notification;
import model.Post;
import model.User;
import service.friend.FriendServiceIMPL;
import service.friend.IFriendService;
import service.like.ILikeService;
import service.like.LikeServiceIMPL;
import service.messenger.IMessengerService;
import service.messenger.MessengerServiceIMPL;
import service.notification.INotificationService;
import service.notification.NotificationServiceIMPL;
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
    ILikeService likeService;
    INotificationService notificationService;

    @Override
    public void init() throws ServletException {
        postService = new PostServiceIMPL();
        friendService = new FriendServiceIMPL();
        likeService = new LikeServiceIMPL();
        notificationService = new NotificationServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        if(userLogin == null) {
            response.sendRedirect(request.getContextPath());
            return;
        }
        try {
            List<Post> postList = postService.selectAll();
            for (Post post : postList) {
                boolean isLiked = likeService.checkLikePost(post.getId(), userLogin.getId()) != -1;
                post.setLiked(isLiked);
                post.setCountLike(likeService.findByIdPost(post.getId()).size());
            }
            List<Friend> listRequest = friendService.findByUserId(userLogin.getId());
            request.setAttribute("requestNumber", listRequest.size());
            List<User> friendList = friendService.getFriendList(userLogin.getId());
            List<Notification> notificationList = notificationService.findByUserId(userLogin.getId());
            request.setAttribute("friendList", friendList);
            request.setAttribute("postList", postList);
            request.setAttribute("notificationList", notificationList);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/home/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
