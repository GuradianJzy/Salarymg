package common;

import java.sql.Connection;
import java.sql.SQLException;

import java.sql.*;



public class JdbcUtil {
	//��ȡ���ݿ�����
	public static Connection getConnection(String loginName,String password) throws Exception{
		Connection conn = null;
		//��������
		Class.forName(Constants.DB_DRIVER);
		conn = DriverManager.getConnection(Constants.DB_URL,loginName,password);
		return  conn;
	}
	//�ر�����
	public static void closeConnection(Connection conn){
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//�ع�����
	public static void rollbackConnection(Connection conn){
		if(conn != null){
			try {
				conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
