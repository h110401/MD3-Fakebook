package service.role;

import model.Role;
import model.RoleName;
import service.Config;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RoleServiceIMPL implements IRoleService {
    @Override
    public Role findByRoleName(RoleName roleName) {
        String SQL = "SELECT id,name from role where name = ?";
        try (
                Connection conn = Config.getConnection();
                PreparedStatement ps = conn.prepareStatement(SQL);
        ) {
            ps.setString(1, roleName.toString());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                return new Role(id, RoleName.valueOf(name.toUpperCase()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
