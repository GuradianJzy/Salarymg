package domain;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;

import java.sql.SQLException;

import javax.swing.JOptionPane;

import common.JdbcUtil;

public class Users implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userName;
	private String pwd;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPws(String pwd) {
		this.pwd = pwd;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public void login(Users u) throws Exception{
		Connection conn=JdbcUtil.getConnection(u.getUserName(), u.getPwd());

	String sql="select * from users";//�����˺š����뱣���ڱ�users��
	boolean isMatch=false;
	try
	{
	Statement st=conn.createStatement();
	ResultSet rs=st.executeQuery(sql);
	while(rs.next())
	{
	String name=rs.getString("name");//���ݿ��ֶ�����������ʵ����д
	if(name.equals(userName))//�����������������ݿ��е�������ͬ����Ƚ�����
	{
	String p=rs.getString("password");//�����ֶΣ��밴ʵ�����д
	if(p.equals(pwd)) //�������������ݿ������뱣��
	{
	isMatch=true;
	break;
	}
	}
	}
	if(isMatch)	//����˻���������ƥ��
	{
	//��Ӧ�Ĵ���
	}
	else
	{
	JOptionPane.showMessageDialog(null,"�û�����������󣡣�");
	//��������
	}
	}
	catch(Exception e)//�쳣����
	{}
}
}
