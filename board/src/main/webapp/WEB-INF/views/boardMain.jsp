<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

</head>
<body>
<div class="container" style="margin-top: -100px">
    <table class="table table-hover table-striped text-center" style="border: 1px solid;">
        <thead>
        <tr>
            <th>NO</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일자</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${fn:length(boardList) > 0}">
            <c:forEach var="dto" items="${boardList}" varStatus="idx">
                    <tr onclick="location.href = 'boardDetail?page=${page.page}&range=${page.range}&id=${dto.board_id_seq}'" style="cursor:pointer">
                        <td>${dto.board_no_seq}</td>
                        <td>${dto.board_subject}</td>
                        <td>${dto.board_writer}</td>
                        <td><fmt:formatDate value="${dto.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                        <td>${dto.board_hits}</td>
                    </tr>
                <br/>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
        <a class="btn btn-outline-info" href="boardWriteForm" style="display: inline-block; float: right;" >글 작성</a>
    <div class="pull-right">
        <ul class="pagination">
            <c:if test="${page.prev}">
                <li class="page-item">
                    <a class="page-link prev_a" href="#" onclick="prev_page(${page.page}, ${page.range}, ${page.rangeSize})">PREV</a>
                </li>
            </c:if>
            <c:forEach begin="${page.startPage}" end="${page.endPage}" var="idx">
            <li class="page-item <c:out value="${page.page == idx ? 'active' : ''}"/> ">
                <a class="page-link" href="#" onclick="num_page(${idx}, ${page.range})">${idx}</a>
            </li>
            </c:forEach>
            <c:if test="${page.next}">
                <li class="page-item">
                    <a class="page-link next_a" href="#" onclick="next_page(${page.page}, ${page.range}, ${page.rangeSize})">NEXT</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>
    <script>
      function prev_page(page, range, rangeSize) {
        page = parseInt((range-2) * rangeSize) + 1;
        range = range - 1;

        location.href = 'boardMain?page='+page+'&range='+range;
      }

      function num_page(page, range) {
        location.href = 'boardMain?page='+page+'&range='+range;
      }

      function next_page(page, range, rangeSize) {
        page = parseInt((range * rangeSize)) + 1;
        range = parseInt(range) + 1;
        location.href = 'boardMain?page='+page+'&range='+range;

      }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>
