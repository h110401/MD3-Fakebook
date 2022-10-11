package controller;

import model.Like;
import model.Notification;
import model.User;
import service.like.ILikeService;
import service.like.LikeServiceIMPL;
import service.notification.INotificationService;
import service.notification.NotificationServiceIMPL;
import service.post.IPostService;
import service.post.PostServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LikeServlet", value = "/like")
public class LikeServlet extends HttpServlet {
    ILikeService likeService;
    INotificationService notificationService;

    IPostService postService;

    @Override
    public void init() throws ServletException {
        likeService = new LikeServiceIMPL();
        notificationService = new NotificationServiceIMPL();
        postService = new PostServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idPostStr = request.getParameter("idPost");
        String idCmtStr = request.getParameter("idCmt");

        if (idCmtStr != null) {
            likeCmt(request, response, idCmtStr, idPostStr);
        } else {
            likePost(request, response, idPostStr);
        }

    }

    private void likeCmt(HttpServletRequest request, HttpServletResponse response, String idCmtStr, String idPostStr) {
        try {
            int idCmt = Integer.parseInt(idCmtStr);
            User userLogin = (User) request.getSession().getAttribute("userLogin");
            Like like = new Like();
            like.setIdComment(idCmt);
            like.setIdUser(userLogin.getId());
            int isLiked = likeService.checkLikeCmt(idCmt, userLogin.getId());
            if (isLiked != -1) {
                likeService.removeLikeCmt(isLiked);
            } else {
                likeService.save(like);
            }
            response.sendRedirect("post?action=detail&id=" + idPostStr);
        } catch (SQLException | ClassNotFoundException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void likePost(HttpServletRequest request, HttpServletResponse response, String idPostStr) throws IOException {
        try {
            int idPost = Integer.parseInt(idPostStr);
            User userLogin = (User) request.getSession().getAttribute("userLogin");
            Like like = new Like();
            like.setIdPost(idPost);
            like.setIdUser(userLogin.getId());
            int isLiked = likeService.checkLikePost(idPost, userLogin.getId());
            if (isLiked != -1) {
                likeService.removeLikePost(isLiked);
            } else {
                likeService.save(like);

                int idFrom = userLogin.getId();
                int idTo = postService.getById(idPost).getUser().getId();
                if (idFrom != idTo) {
                    String content = userLogin.getName() + " liked your post " + idPost;
                    Notification notification = new Notification();
                    notification.setContent(content);
                    notification.setIdFrom(idFrom);
                    notification.setIdTo(idTo);
                    notification.setIdPost(idPost);
                    notificationService.save(notification);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String direction = request.getParameter("direction");
        if (direction == null) {
            response.sendRedirect("home");
        } else if (direction.equals("post")) {
            response.sendRedirect("post?action=detail&id=" + idPostStr);
        } else if (direction.equals("wall")) {
            int id = Integer.parseInt(request.getParameter("id"));
            response.sendRedirect("user?profile="+id);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
