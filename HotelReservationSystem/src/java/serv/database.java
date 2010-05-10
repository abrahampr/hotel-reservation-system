package serv;

import javax.naming.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;

public class database {
//declare the variable

    private static Connection connection = null;
    private static Statement statement = null;
    private static ResultSet resultset = null;
//connection to the database

    public static Connection getConnection() {
        try {
//initial the context
            Context initial = new InitialContext();
//set the datasource
            DataSource datasource = (DataSource) initial.lookup("java:comp/env/jdbc/hrs");
            connection = datasource.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
//diconnection to the database

    public static void closeConnection() {
        try {
            //check the variable if not null then close the connection
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
//check the value if it is exist

    public static boolean isExist(String sqla) {
        boolean judgment = false;
        try {
            String sql = new String(sqla);
            connection = database.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(sql);
            if (resultset.next()) {
                judgment = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return judgment;
    }
//update the sql syntax

    public static int update(String sqla) {
        int counter = 0;
        try {
            String sql = new String(sqla);
            connection = database.getConnection();
            statement = connection.createStatement();
            counter = statement.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return counter;
    }
//update the sql syntax

    public static boolean update(String sqla, String sqlb) {
        boolean judgment = false;
        try {
            connection = database.getConnection();
            connection.setAutoCommit(false);
            statement = connection.createStatement();
            String sql = new String(sqla);
            statement.executeUpdate(sql);
            sql = new String(sqlb);
            statement.executeUpdate(sql);
            connection.commit();
            connection.setAutoCommit(true);
            judgment = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                connection.rollback();
                judgment = false;
            } catch (Exception ea) {
                ea.printStackTrace();
            }
        } finally {
            database.closeConnection();
        }
        return judgment;
    }
//get the information from sql syntax

    public static String getInfomation(String sqla) {
        String Infomation = null;
        try {
            String sql = new String(sqla);
            connection = database.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(sql);
            if (resultset.next()) {
                Infomation = new String(resultset.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return Infomation;
    }
//get the group from sql

    public static Vector<String[]> getGroup() {
//initial the vector array and return the value
        Vector<String[]> vector = new Vector<String[]>();
        try {
            connection = database.getConnection();
            statement = connection.createStatement();
            String sql = "select * from roomgroup";
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                String group[] = new String[5];
                //made the data from database into array
                for (int i = 0; i < group.length; i++) {
                    group[i] = new String(resultset.getString(i + 1));
                }
                //made the data from array into vector
                vector.add(group);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return vector;
    }
//get group information from sql syntax

    public static Vector<String> getGroupInfomation(int groupid) {
        Vector<String> vector = new Vector<String>();
        try {
            connection = database.getConnection();
            statement = connection.createStatement();
            String sql = "select groupid,groupname,groupdetails,grouprules,groupimage from roomgroup where groupid=" + groupid;
            resultset = statement.executeQuery(sql);
            if (resultset.next()) {
                //made the data from database into vector
                for (int i = 1; i < 6; i++) {
                    vector.add(new String(resultset.getString(i)));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return vector;
    }

//get information
    public static String getInfo(String sqla) {
        String Info = null;
        try {
            String sql = new String(sqla.getBytes());
            connection = database.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(sql);
            if (resultset.next()) {
                Info = new String(resultset.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return Info;
    }
//get the total count of sql syntax

    public static int getTotal(int span, int group) {
        int result = 0;
        String sql = "";
        try {
            connection = database.getConnection();
            statement = connection.createStatement();
            if (group == 0) {
                sql = "select count(*) from room";
            } else {
                sql = "select count(*) from room " + "where roomgroup='" + group + "'";
            }
            resultset = statement.executeQuery(sql);
            resultset.next();
//get the record number
            int rows = resultset.getInt(1);
//caculate the total page
            result = rows / span + ((rows % span == 0) ? 0 : 1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return result;
    }
//get the page content
    public static Vector<String[]> getPageContent(int page, int span, int group) {
//declare the vector
        Vector<String[]> v = new Vector<String[]>();
        String sql = "";
//caculate the start row
        int startRow = (page - 1) * span;
        try {
            connection = database.getConnection();
            statement = connection.createStatement();
            if (group == 0) {
                sql = "select roomname,style,cost,details,status,roomid,groupname from "
                        + "room,roomgroup where room.roomgroup=roomgroup.groupid order "
                        + "by roomgroup, roomname, roomid";
            } else {
                sql = "select roomname,style,cost,details,status,roomid,groupname "
                        + "from room,roomgroup where room.roomgroup=roomgroup.groupid "
                        + "and roomgroup='" + group + "' order by roomname";
            }
            resultset = statement.executeQuery(sql);
//if start Row is not null, resultset set to the start row
            if (startRow != 0) {
                resultset.absolute(startRow);
            }
//create array and put the data into this array
            int c = 0;
//control the record numbers in each page
            while (c < span && resultset.next()) {
                String s[] = new String[7];
                for (int i = 0; i < s.length; i++) {
                    s[i] =
                            new String(resultset.getString(i + 1));
                }
                v.add(s);
                c++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return v;
    }
//get Id

    public static int getId(String table, String row) {
        int id = 0;
        try {
            System.out.println(row);
            connection = database.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select count(*) from " + table + "");
            resultset.next();
            if (resultset.getInt(1) == 0) {
                id = 1;
            } else {
                resultset = statement.executeQuery("select max(" + row + ") from " + table + "");
                resultset.next();
                id = Integer.parseInt(resultset.getString(1)) + 1;
                System.out.println(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return id;
    }
//get admin info

    public static Vector<String[]> getAdminInfo() {
        Vector<String[]> v = new Vector<String[]>();
        try {
            connection = database.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select adminusername,authority from admin");
            while (resultset.next()) {
                String s[] = new String[2];
                s[0] = new String(resultset.getString(1));
                s[1] = new String(resultset.getString(2));
                v.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            database.closeConnection();
        }
        return v;
    }
//get rooom information

    public static Vector<String[]> getRoomInformation(String sqla) {
        Vector<String[]> v = new Vector<String[]>();
        try {
            connection = database.getConnection();
            statement = connection.createStatement();
            String sql = new String(sqla);
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                String s[] = new String[8];
                for (int i = 0; i < s.length - 1; i++) {
                    s[i] = new String(resultset.getString(i + 1));
                }
                v.add(s);
            }
            for (String s[] : v) {
                String sqlb = "select groupname from roomgroup where groupid='" + s[5] + "'";
                resultset = statement.executeQuery(sqlb);
                resultset.next();
                s[7] = new String(resultset.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            database.closeConnection();
        }
        return v;
    }
}
