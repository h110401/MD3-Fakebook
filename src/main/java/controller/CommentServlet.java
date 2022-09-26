package controller;

import model.Comment;
import model.User;
import service.comment.CommentServiceIMPL;
import service.comment.ICommentService;
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

    @Override
    public void init() throws ServletException {
        commentService = new CommentServiceIMPL();
        userService = new UserServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idPost = Integer.parseInt(request.getParameter("idPost"));
        String commentContent = request.getParameter("comment-content");
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        Comment comment = new Comment();
        comment.setIdUser(userLogin.getId());
        comment.setIdPost(idPost);
        comment.setContent(commentContent);
        try {
            commentService.save(comment);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        response.sendRedirect("post?action=detail&id=" + idPost);
    }
}
