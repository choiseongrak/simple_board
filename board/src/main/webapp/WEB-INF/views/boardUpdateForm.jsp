<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

</head>
<body>
    <a href="boardMain">게시판으로 이동</a>
    <form class="writeForm" action="boardUpdate" method="post">
        <input type="hidden" name="board_id_seq" value="${boardDTO.board_id_seq}">
        <input type="hidden" name="page" value="${page}">
        <input type="hidden" name="range" value="${range}">
        <div class="form-group">
            <label for="writer">작성자</label>
                <input id="writer" class="form-control writer" name="board_writer" value="${boardDTO.board_writer}"/>
        </div>
        <div class="form-group">
            <label for="subject">제목</label>
            <input id="subject" class="form-control mt-4 mb-2 subject" name="board_subject" value="${boardDTO.board_subject}"/>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
                <textarea id="content" class=" form-control content" name="board_content" rows="10">${boardDTO.board_content}</textarea>
        </div>
        <button type="reset" class="btn btn-outline-info">취소</button>
        <button type="submit" class="btn btn-info">수정</button>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>
