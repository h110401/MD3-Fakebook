package controller;

import model.RoleName;
import model.User;
import service.role.RoleServiceIMPL;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    IUserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login/sign-up.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String firstName = request.getParameter("first-name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String name = firstName.trim() + " " + surname.trim();

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.getRoles().add(new RoleServiceIMPL().findByRoleName(RoleName.USER));

        try {
            userService.save(user);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        response.sendRedirect("login");
    }
}
