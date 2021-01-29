<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <style>
        /*문의 답변 페이지*/
        div.qnaDiv {
            margin-top: 50px;
        }
        ul.qnaList{
            padding: 0 10px;

        }
        ul.qnaList li{
            display: flex;
            justify-content: space-between;
            padding: 5px 0px;
        }
        ul.qnaList strong{
            width: 20%;
        }
        ul.qnaList span{
            width:100%
        }
        ul.qnaList span.regidate{
            width: 100%;
            text-align: right;
            opacity: 0.3;
        }

        .qnaList.q{
            display: flex;
            flex-direction: column;
            width: 100%;
            margin: 2% auto;
            padding: 3%;
            border: 1px solid #d1d3d5;
        }
        .answer form{
            display: flex;
            height: 120px;
        }

        #replyDiv form{
            display: flex;
            height: 40px;
        }

        .answer textarea,
        #replyDiv textarea{
            width: 90%;
            border: 1px solid #51ABF3;
            resize: none;
        }
        .answer .replyBtn,
        #replyDiv .replyBtn{
            width: 10%;
            background: #007bff;
            color: #fff;
            border: 1px solid #007bff;
            border-radius: 4px;
        }
        .answer .writer,
        #replyDiv .writer{
            width: 10%;
            height: 24px;
        }
        ul.qnaList span.regidate{
            width: 100%;
            text-align: right;
            opacity: 0.3;
        }
    </style>
</head>
<body>
<div class="container">
    <ul class="qnaList q">
        <li>
            <strong>게시글 ID</strong>
            <span>${boardDTO.board_id_seq}</span>
        </li>
        <li>
            <strong>제목</strong>
            <span>${boardDTO.board_subject}</span>
        </li>
        <li>
            <strong>작성자</strong>
            <span>${boardDTO.board_writer}</span>
        </li>
        <li>
            <strong>작성일자</strong>
            <span><fmt:formatDate value="${boardDTO.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></span>
        </li>
        <li>
            <strong>조회수</strong>
            <span>${boardDTO.board_hits}</span>
        </li>
        <li>
            <strong>내용</strong>
            <span>${boardDTO.board_content}</span>
        </li>
    </ul>
    <!-- 답변등록 -->
    <div class="answer">
        <form class="answerForm">
            <input type="hidden" name="board_group" value="${boardDTO.board_group}">
            <input type="hidden" name="board_id" value="${boardDTO.board_id_seq}">
            <input type="hidden" name="user_id" value="${loginMember.user_id}">
            <input type="text" name="board_writer" class="writer" placeholder="작성자" >
            <textarea name="reply_content" cols="100" rows="10" placeholder="댓글 입력"></textarea>
            <input type="button" class="replyBtn" value="댓글 등록" onclick="reply()">
        </form>
    </div>
    <c:if test="${loginMember.user_id eq boardDTO.user_id}">
        <a class="btn btn-outline-info" href="boardDelete?id=${boardDTO.board_id_seq}&page=${page}&range=${range}" style="display: inline-block; margin: 10px 0 0 10px; float: right;" >삭제</a>
        <a class="btn btn-outline-info" href="boardUpdateForm?id=${boardDTO.board_id_seq}&page=${page}&range=${range}" style="display: inline-block; margin: 10px 0 0 10px; float: right;" >수정</a>
    </c:if>
    <a class="btn btn-outline-info" href="boardMain?page=${page}&range=${range}" style="display: inline-block; margin: 10px 0 0 10px; float: right;" >목록</a>
    <div class="qnaDiv">
        <c:if test="${fn:length(replyList) != 0}">
            <c:forEach var="reply" items="${replyList}" varStatus="idx">
            <ul class="qnaList" id="reply_list">
                <li>
                    <strong>${reply.board_id_seq}</strong>
                    <strong>${reply.board_writer}</strong>
                    <span class="regidate"><fmt:formatDate value="${reply.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></span>
                </li>
                <li>
                    <span>${reply.board_content}</span>
                    <button class="btn btn-outline-info reply_replyBtn" value="${loginMember.user_id}" onclick="re_replyForm(event,'${reply.board_re_lev}')" style="width: 50px; height: 20px; padding: 0; font-size: 12px;">답글</button>
                    <c:if test="${loginMember.user_id eq reply.user_id}">
                        <a class="btn btn-outline-info" href="#" style="width: 50px; height: 20px; padding: 0; font-size: 12px;">수정</a>
                        <a class="btn btn-outline-info" href="replyDelete?id=${boardDTO.board_id_seq}&del_id=${reply.board_id_seq}&page=${page}&range=${range}" style="width: 50px; height: 20px; padding: 0; font-size: 12px;">삭제</a>
                    </c:if>
                </li>
            </ul>
                <c:forEach var="re_reply" items="${reReplyList}">
                    <c:if test="${reply.board_id_seq eq re_reply.board_re_lev}">
                        <ul class="qnaList" style="margin-left: 50px">
                            <li>
                                <strong>${re_reply.board_writer}</strong>
                                <span class="regidate"><fmt:formatDate value="${re_reply.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></span>
                            </li>
                            <li>
                                <span>${re_reply.board_content}</span>
                                <c:if test="${loginMember.user_id eq re_reply.user_id}">
                                    <a class="btn btn-outline-info" href="#" style="width: 50px; height: 20px; padding: 0; font-size: 12px;">수정</a>
                                    <a class="btn btn-outline-info" href="replyDelete?id=${boardDTO.board_id_seq}&del_id=${re_reply.board_id_seq}&page=${page}&range=${range}" style="width: 50px; height: 20px; padding: 0; font-size: 12px;">삭제</a>
                                </c:if>
                            </li>
                        </ul>
                    </c:if>
                </c:forEach>
            </c:forEach>
        </c:if>
    </div>
</div>
<script>
    function reply() {
      const board_group = $("input[name=board_group]").val();
      const user_id = $("input[name=user_id]").val();
      const board_content = $("textarea[name=reply_content]").val();
      const board_writer = $("input[name=board_writer]").val();
      console.log(board_group);
      console.log(user_id);
      console.log(board_content);
      console.log(board_writer);

      $.ajax({
        type: 'post',
        url: 'replyWrite',
        data: {
          board_group: board_group,
          user_id: user_id,
          board_content: board_content,
          board_writer: board_writer,
        },
        dataType: "text",
        success: function () {
          console.log("성공");
            location.reload();
        },
        error: function (xhr, status, error) {
          console.log("실패");
        },
      })
    }

    function re_replyForm(event, board_re_lev) {
      console.log(board_re_lev);
      const btn = event.target;
      const parent = btn.parentElement;
      const user_id = btn.value;
      $("#replyDiv").remove();
      parent.insertAdjacentHTML('afterend', getHtml(board_re_lev, user_id));
    }

    function getHtml(board_re_lev, user_id) {
      const board_group = $("input[name=board_group]").val();
      console.log(user_id);
      let result = "";
      result += "<div class='answer' id='replyDiv'>" +
        "<form class='answerForm'>"+
            "<input type='hidden' class='re_board_group' name='board_group' value='" + board_group + "'>" +
            "<input type='hidden' class='re_board_re_lev' name='board_re_lev' value='" + board_re_lev + "'>" +
            "<input type='hidden' class='re_user_id' name='user_id' value='" + user_id + "'>" +
            "<input type='text' class='re_board_writer' name='board_writer' placeholder='작성자' >" +
            "<textarea class='re_reply_content' name='reply_content' cols='100' rows='3' placeholder='답글 입력'></textarea>" +
            "<input type='button' class='replyBtn' value='답글 등록' onclick='re_reply()'>" +
        "</form></div>";
      return result;
    }

    function re_reply() {
      const board_group = $(".re_board_group").val();
      const board_re_lev = $(".re_board_re_lev").val();
      const user_id = $(".re_user_id").val();
      const board_content = $(".re_reply_content").val();
      const board_writer = $(".re_board_writer").val();
      console.log(board_group);
      console.log(user_id);
      console.log(board_content);
      console.log(board_writer);

      $.ajax({
        type: 'post',
        url: 'reReplyWrite',
        data: {
          board_re_lev: board_re_lev,
          board_group: board_group,
          user_id: user_id,
          board_content: board_content,
          board_writer: board_writer,
        },
        dataType: "text",
        success: function () {
          console.log("성공");
          location.reload();
        },
        error: function (xhr, status, error) {
          console.log("실패");
        },
      })
    }




</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>
