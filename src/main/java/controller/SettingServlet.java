package controller;

import model.User;
import service.user.IUserService;
import service.user.UserServiceIMPL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "SettingServlet", value = "/setting")
public class SettingServlet extends HttpServlet {
    IUserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceIMPL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            default:
                listUser(request, response);
        }
    }

    private void listUser(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<User> userList = userService.selectAll();
            for (User user : userList) {
                user.setRoles(userService.findRoleByUserId(user.getId()));
            }
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("setting/setting.jsp").forward(request, response);
        } catch (ServletException | IOException | ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
