<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="VOTE.JDBConnect"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표검수조회</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<section class="main-section">
    <h2 style="text-align:center">투표검수조회</h2><br>
    <table>
    <tr>
        <th>성명</th>
        <th>생년월일</th>
        <th>나이</th>
        <th>성별</th>
        <th>후보번호</th>
        <th>투표시간</th>
        <th>유권자 확인</th>
    </tr>
    <%
    JDBConnect jdbc = new JDBConnect();
    System.out.println("voteList.jsp");

    try {
        // SQL 쿼리 작성
        String sql = " SELECT " 
                   + " V.V_NAME AS 성명, " 
                   + " CASE " 
                   + " WHEN SUBSTR(V.V_JUMIN, 1, 1) = '0' THEN '20' || SUBSTR(V.V_JUMIN, 1, 2) || '년 ' || SUBSTR(V.V_JUMIN, 3, 2) || '월 ' || SUBSTR(V.V_JUMIN, 5, 2) || '일생' " 
                   + " ELSE '19' || SUBSTR(V.V_JUMIN, 1, 2) || '년 ' || SUBSTR(V.V_JUMIN, 3, 2) || '월 ' || SUBSTR(V.V_JUMIN, 5, 2) || '일생' " 
                   + " END AS 생년월일, " 
                   + " TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(" 
                   + " CASE " 
                   + " WHEN SUBSTR(V.V_JUMIN, 1, 1) = '0' THEN '20' || SUBSTR(V.V_JUMIN, 1, 2) " 
                   + " ELSE '19' || SUBSTR(V.V_JUMIN, 1, 2) " 
                   + " END || SUBSTR(V.V_JUMIN, 3, 2) || SUBSTR(V.V_JUMIN, 5, 2), 'YYYYMMDD') " 
                   + " ) / 12) AS 나이, " 
                   + " CASE WHEN SUBSTR(V.V_JUMIN, 7, 1) = '1' THEN '남' " 
                   + " WHEN SUBSTR(V.V_JUMIN, 7, 1) = '2' THEN '여' " 
                   + " ELSE '알수없음' END AS 성별, " 
                   + " V.M_NO AS 후보번호, " 
                   + " TO_CHAR(TO_DATE(V.V_TIME, 'HH24MI'), 'HH24:MI') AS 투표시간, " 
                   + " CASE V.V_CONFIRM WHEN 'Y' THEN '확인' ELSE '미확인' END AS 유권자_확인 " 
                   + " FROM TBL_VOTE V " 
                   + " WHERE V.V_AREA = '제1투표장'";

        PreparedStatement pstmt = jdbc.con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            // 데이터 조회
            String name = rs.getString("성명");
            String birthDate = rs.getString("생년월일");
            String age = rs.getString("나이");
            String gender = rs.getString("성별");
            String candidateNo = rs.getString("후보번호");
            String voteTime = rs.getString("투표시간");
            String voterStatus = rs.getString("유권자_확인");

            // HTML 출력
            out.println("<tr>");
            out.println("<td>" + name + "</td>");
            out.println("<td>" + birthDate + "</td>");
            out.println("<td>만 " + age + "세</td>");
            out.println("<td>" + gender + "</td>");
            out.println("<td>" + candidateNo + "</td>");
            out.println("<td>" + voteTime + "</td>");
            out.println("<td>" + voterStatus + "</td>");
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
