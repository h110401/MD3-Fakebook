package controller;

import model.Comment;
import model.Post;
import model.User;
import service.comment.CommentServiceIMPL;
import service.comment.ICommentService;
import service.post.IPostService;
import service.post.PostServiceIMPL;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "PostServlet", value = "/post")
public class PostServlet extends HttpServlet {

    IPostService postService;
    ICommentService commentService;

    @Override
    public void init() throws ServletException {
        postService = new PostServiceIMPL();
        commentService = new CommentServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "detail":
                detailPost(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "create":
                createPost(request, response);
                break;
            case "delete":
                deletePost(request, response);
                break;
        }

    }

    private void detailPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Post post = postService.getById(id);
            List<Comment> commentList = commentService.findByIdPost(id);
            request.setAttribute("post", post);
            request.setAttribute("commentList", commentList);
            request.getRequestDispatcher("/post/post-detail.jsp").forward(request, response);
        } catch (ServletException | IOException | SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idPost = Integer.parseInt(request.getParameter("idPost"));

        try {
            if (postService.getById(idPost).getUser().getId() == ((User) request.getSession().getAttribute("userLogin")).getId()) {
                postService.remove(idPost);
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("home");
    }

    private void createPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String content = request.getParameter("content");
        String imgSrc = request.getParameter("imgSrc");
        int idUser = ((User) request.getSession().getAttribute("userLogin")).getId();
        User user;
        try {
            user = new UserServiceIMPL().getById(idUser);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String dateCreated = request.getParameter("date-created");

        Post post = new Post();
        post.setContent(content);
        post.setImgUrl(imgSrc);
        post.setUser(user);
        post.setCreatedDate(dateCreated);

        try {
            postService.save(post);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("home");
    }

}
