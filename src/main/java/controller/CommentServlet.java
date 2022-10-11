package controller;

import model.Comment;
import model.Notification;
import model.User;
import service.comment.CommentServiceIMPL;
import service.comment.ICommentService;
import service.like.ILikeService;
import service.like.LikeServiceIMPL;
import service.notification.INotificationService;
import service.notification.NotificationServiceIMPL;
import service.post.IPostService;
import service.post.PostServiceIMPL;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "CommentServlet", value = "/comment")
public class CommentServlet extends HttpServlet {
    ICommentService commentService;
    IUserService userService;
    ILikeService likeService;
    IPostService postService;
    INotificationService notificationService;

    @Override
    public void init() throws ServletException {
        commentService = new CommentServiceIMPL();
        userService = new UserServiceIMPL();
        likeService = new LikeServiceIMPL();
        postService = new PostServiceIMPL();
        notificationService = new NotificationServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "delete":
                deleteComment(request, response);
                break;
            default:
                int idPost = Integer.parseInt(request.getParameter("idPost"));
                response.sendRedirect("post?action=detail&id=" + idPost);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createComment(request, response);
                break;
        }

    }

    private void deleteComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            commentService.remove(id);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        int idPost = Integer.parseInt(request.getParameter("idPost"));
        response.sendRedirect("post?action=detail&id=" + idPost);
    }

    private void createComment(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idPost = Integer.parseInt(request.getParameter("idPost"));
            String commentContent = request.getParameter("comment-content");
            User userLogin = (User) request.getSession().getAttribute("userLogin");
            Comment comment = new Comment();
            comment.setIdUser(userLogin.getId());
            comment.setIdPost(idPost);
            comment.setContent(commentContent);

            commentService.save(comment);

            int idFrom = userLogin.getId();
            int idTo = postService.getById(idPost).getUser().getId();
            if (idFrom != idTo) {
                String content = userLogin.getName() + " commented on your post " + idPost;
                Notification notification = new Notification();
                notification.setContent(content);
                notification.setIdFrom(idFrom);
                notification.setIdTo(idTo);
                notification.setIdPost(idPost);
                notificationService.save(notification);
            }

            response.sendRedirect("post?action=detail&id=" + idPost);
        } catch (SQLException | ClassNotFoundException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}
