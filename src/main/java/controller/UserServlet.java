package controller;

import model.Friend;
import model.Post;
import model.User;
import service.friend.FriendServiceIMPL;
import service.friend.IFriendService;
import service.like.ILikeService;
import service.like.LikeServiceIMPL;
import service.post.IPostService;
import service.post.PostServiceIMPL;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/user")
public class UserServlet extends HttpServlet {

    IUserService userService;
    IPostService postService;
    ILikeService likeService;
    IFriendService friendService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceIMPL();
        postService = new PostServiceIMPL();
        likeService = new LikeServiceIMPL();
        friendService = new FriendServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String profile = request.getParameter("profile");
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        if (profile != null && !profile.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(profile);
                User user = userService.getById(id);
                if (user != null) {
                    List<Post> postList = postService.findByUserId(id);
                    for (Post post : postList) {
                        boolean isLiked = likeService.checkLikePost(post.getId(), userLogin.getId()) != -1;
                        post.setLiked(isLiked);
                        post.setCountLike(likeService.findByIdPost(post.getId()).size());
                    }
                    request.setAttribute("user", user);
                    request.setAttribute("postList", postList);
                    Friend friend = friendService.findFriendRequest(userLogin.getId(), id);
                    request.setAttribute("relative", friendService.getFriendStatus(friend, userLogin.getId()));
                    request.getRequestDispatcher("wall/wall.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("error-404.jsp").forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "change-name":
                try {
                    changeName(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "change-avatar":
                changeAvatar(request, response);
                break;
            case "change-pass":
                changePass(request, response);
                break;
        }


    }

    private void changePass(HttpServletRequest request, HttpServletResponse response) {
        User userLogin = (User) request.getSession().getAttribute("userLogin");
        String pass = request.getParameter("pass");
        if (!pass.trim().isEmpty()) {
            userLogin.setPassword(pass);
            try {
                userService.update(userLogin);

                response.sendRedirect("/logout");

            } catch (SQLException | IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            try {
                List<Post> postList = postService.findByUserId(userLogin.getId());
                for (Post post : postList) {
                    boolean isLiked = likeService.checkLikePost(post.getId(), userLogin.getId()) != -1;
                    post.setLiked(isLiked);
                    post.setCountLike(likeService.findByIdPost(post.getId()).size());
                }
                request.setAttribute("user", userLogin);
                request.setAttribute("postList", postList);
                request.getRequestDispatcher("wall/wall.jsp").forward(request, response);
            } catch (SQLException | ClassNotFoundException | ServletException | IOException e) {
                throw new RuntimeException(e);
            }
        }


    }

    private void changeAvatar(HttpServletRequest request, HttpServletResponse response) {
        String avatar = request.getParameter("imgSrc");
        User userLogin = (User) request.getSession().getAttribute("userLogin");

        if (avatar != null && !avatar.trim().isEmpty()) {

            userLogin.setAvatar(avatar);

            try {
                userService.update(userLogin);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            request.getSession().setAttribute("userLogin", userLogin);
        }

        try {
            List<Post> postList = postService.findByUserId(userLogin.getId());
            for (Post post : postList) {
                boolean isLiked = likeService.checkLikePost(post.getId(), userLogin.getId()) != -1;
                post.setLiked(isLiked);
                post.setCountLike(likeService.findByIdPost(post.getId()).size());
            }
            request.setAttribute("user", userLogin);
            request.setAttribute("postList", postList);
            request.getRequestDispatcher("wall/wall.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException | ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void changeName(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        String name = request.getParameter("name");
        User userLogin = (User) request.getSession().getAttribute("userLogin");

        if (name != null && !name.trim().isEmpty()) {

            userLogin.setName(name);

            userService.update(userLogin);

            request.getSession().setAttribute("userLogin", userLogin);
        }

        try {
            List<Post> postList = postService.findByUserId(userLogin.getId());
            for (Post post : postList) {
                boolean isLiked = likeService.checkLikePost(post.getId(), userLogin.getId()) != -1;
                post.setLiked(isLiked);
                post.setCountLike(likeService.findByIdPost(post.getId()).size());
            }
            request.setAttribute("user", userLogin);
            request.setAttribute("postList", postList);
            request.getRequestDispatcher("wall/wall.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException | ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}
