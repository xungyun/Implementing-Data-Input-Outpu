<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="VOTE.JDBConnect"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후보조회</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<section class="main-section">
    <h2 style="text-align:center">후보조회</h2><br>
    <table border="1">
        <tr>
            <th>후보번호</th>
            <th>성명</th>
            <th>소속정당</th>
            <th>학력</th>
            <th>주민번호</th>
            <th>지역구</th>
            <th>대표전화</th>
        </tr>
        <%
        JDBConnect jdbc = new JDBConnect();
        System.out.println("teacher.jsp");

        try {
            String sql = " SELECT M.M_NO AS 후보번호, M.M_NAME AS 성명, P.P_NAME AS 소속정당, " 
                       + " CASE " 
                       + " WHEN M.P_SCHOOL = '1' THEN '고졸' " 
                       + " WHEN M.P_SCHOOL = '2' THEN '학사' " 
                       + " WHEN M.P_SCHOOL = '3' THEN '석사' " 
                       + " WHEN M.P_SCHOOL = '4' THEN '박사' " 
                       + " ELSE '정보 없음' " 
                       + " END AS 학력, " 
                       + " M.M_JUMIN AS 주민번호, " 
                       + " M.M_CITY AS 지역구, " 
                       + " P.P_TEL1 AS 전화번호1, " 
                       + " P.P_TEL2 AS 전화번호2, " 
                       + " P.P_TEL3 AS 전화번호3 " 
                       + " FROM TBL_CANDIDATE M " 
                       + " JOIN TBL_PARTY P ON M.P_CODE = P.P_CODE";

            PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // 데이터 조회
                String candidateNo = rs.getString("후보번호");
                String name = rs.getString("성명");
                String partyName = rs.getString("소속정당");
                String school = rs.getString("학력");
                String jumin = rs.getString("주민번호");
                String city = rs.getString("지역구");
                String tel1 = rs.getString("전화번호1");
                String tel2 = rs.getString("전화번호2");
                String tel3 = rs.getString("전화번호3");

                // 주민번호 포맷팅
                String formatjumin = jumin.substring(0, 6) + "-" + jumin.substring(6);

                // 전화번호 포맷팅
                String formatPhone = tel1 + "-" + tel2 + "-" + tel3;

                // HTML 출력
                out.println("<tr>");
                out.println("<td>" + candidateNo + "</td>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + partyName + "</td>");
                out.println("<td>" + school + "</td>");
                out.println("<td>" + formatjumin + "</td>");
                out.println("<td>" + city + "</td>");
                out.println("<td>" + formatPhone + "</td>");
                out.println("</tr>");
            }
        } catch (SQLException e) {
            out.println("데이터베이스 오류 발생 : " + e.getMessage());
        } finally {
            jdbc.close();
        }
        %>
    </table>
</section>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
