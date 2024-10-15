<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="VOTE.JDBConnect" %>    


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>투표소관리 프로그램</title>
   <style> 
   td {
    padding-left: 10px;
    text-align:left;
    }
   </style>
</head>
<body>
    <script src = "script.js" ></script>
   <jsp:include page ="header.jsp"></jsp:include>
   <section class="main-section">
 
<%
    System.out.println("voteMember.jsp");		
%>
 
<h2> 투표하기</h2> <br>
<form name="frm" method = "post" action="action.jsp" >

 <table>
<tr>
			<th>주민번호</th>
			<td>
			<input type="text" name="v_jumin" placeholder="ex) 8906153154726">
			</td>
		</tr>
		<tr>
			<th>성명</th>
			<td>
			<input type="text" name="v_name">
			</td>
		</tr>
		<tr>
			<th>투표번호</th>
			<td>
			<select name="m_no">
				<option>---선택---</option>
				<option value="1">[1]김후보</option>
				<option value="2">[2]이후보</option>
				<option value="3">[3]박후보</option>
				<option value="4">[4]조후보</option>
				<option value="5">[5]최후보</option>
			</select>		
			</td>
		</tr>
		<tr>
			<th>투표시간</th>
			<td>
			<input type="text" name="v_time" placeholder="ex) 0930">
			</td>
		</tr>
		<tr>
			<th>투표장소</th>
			<td>
			<input type="text" name="v_area" placeholder="ex) 제1투표장">
			</td>
		</tr>
		<tr>
			<th>유권자확인</th>
			<td>
			<input style="float:none;" type="radio" name="v_confirm" value="Y">확인 
			<input style="float:none;" type="radio" name="v_confirm" value="N">미확인
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center">
			<button class="btn" type="submit" onclick="fn_submit();return false;">투표하기</button>
			<button class="btn" type="button" onclick="fn_reset()">다시하기</button>
			</td>
		</tr>
	
		

 
</table>
</form>

</section>


 <jsp:include page="footer.jsp"></jsp:include>

</body>
</html>