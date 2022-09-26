package controller;

import model.User;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    IUserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (request.getAttribute("id") != null) {
            int id = Integer.parseInt(String.valueOf(request.getAttribute("id")));
            User user = null;
            try {
                user = userService.getById(id);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            if (user != null) {
                request.getSession().setAttribute("userLogin", user);
                response.sendRedirect("home");
            } else {
                request.getRequestDispatcher("/login/login.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/login/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int isLogin;
        try {
            isLogin = userService.isAuthenticated(email, password);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        if (isLogin != -1) {
            User user;
            try {
                user = userService.getById(isLogin);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }

            Cookie userId = new Cookie("id", String.valueOf(isLogin));
            response.addCookie(userId);

            request.getSession().setAttribute("userLogin", user);
            response.sendRedirect("home");
        } else {
            response.sendRedirect("login");
        }
    }
}
