<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*, com.vodcaster.sqlbean.*, com.yundara.util.*,java.io.*"%>
<jsp:useBean id="subjectbean" class="com.vodcaster.sqlbean.SubjectSqlBean"/>

<%
	/**
	 * @author 주현
	 *
	 * @description : 설문생성
	 * date : 2008-03-25
	 */

	request.setCharacterEncoding("euc-kr");
	String sub_flag = "S"; // S - 설문 ,  E - 이벤트
	if(request.getParameter("sub_flag") != null && request.getParameter("sub_flag").length()>0){
		sub_flag = request.getParameter("sub_flag");
	}

	String question_count = request.getParameter("question_count"); 
	String sub_idx = request.getParameter("sub_idx"); 
//	String question_idx = "";  // 문제 번호
//	String info_ip =request.getRemoteAddr(); // 아이피
//	String info_order = ""; // 기타 내용 적은것 
	String info_etc = "0"; // 예비
	String user_idx = ""; // 사용자 정보
//	String ans = ""; // 답 번호
//	String ans_order = ""; // textarea

	int point = 0;

	if (question_count != null && question_count.length() > 0){

	int result = subjectbean.insert_user(request);  // result 값으로user_idx 값을 받음 (사용자 정보 입력)
	if (result > 0) {
		user_idx = String.valueOf(result);
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('등록에 실패 하였습니다.')self.close();</script>");
	}
//	request.getRemoteAddr()  //아이피
//  subjectbean.insert_info2(sub_idx ,question_idx ,info_ip , info_order ,info_etc , user_idx , ans , ans_order)
	String Q_no = "";
		for (int i = 0; i < Integer.parseInt(question_count) ; i++) {

			Q_no = request.getParameter("Q"+i); 

			// 문제 번호에 해당하는 value 값이 저장된 값을 가져오기 위한 name 이 됨  
			//request.getParameter(Q_no); 값이 구해야할 값


			if (Q_no != null && Q_no.length() > 0) {
				StringTokenizer Q_no_st = new StringTokenizer(Q_no, "_");   // 문제 번호와 유형 구하기
				Vector info = new Vector();
				while (Q_no_st.hasMoreTokens()) {
					info.add(Q_no_st.nextToken());
				}

				if (info != null && info.size() > 1) {
							if (info.elementAt(0).equals("option5")) { // textarea
								String ans_order = request.getParameter(String.valueOf(info.elementAt(1)));
//								out.println("문제번호:"+info.elementAt(1) );
								String question_idx = String.valueOf(info.elementAt(1));
								String ans = "0" ;
								String info_order = "";
								if (ans_order != null && ans_order.length() > 0) {  // 입력 값이 있을 경우만 저장
									int result2 = subjectbean.insert_info2(sub_idx ,question_idx ,info_order ,info_etc , user_idx , ans , ans_order);
 
									String ans_right = subjectbean.getAns_order(question_idx).replaceAll(" ","");
//									out.println("==정답=="+ans_right);
//									out.println("=선택답="+ans_order);
									if(ans_right != null && ans_right.equals(ans_order.replaceAll(" ",""))){
										point ++;
									}
								}
							}

							if (info.elementAt(0).equals("option4")) { // 라디오 버튼인경우
									String[] ans_inxArr = request.getParameterValues(String.valueOf(info.elementAt(1))+"_num");
									if (ans_inxArr != null && ans_inxArr.length > 0) {
										
										     String question_idx = String.valueOf(info.elementAt(1));

										for (int j= 0; j <  ans_inxArr.length; j++ ){
											
//											out.println("문제번호:"+info.elementAt(1) + "갯수:"+ans_inxArr.length);
//											out.println("예문번호:"+ans_inxArr[j]);

											String option4_ans = request.getParameter(String.valueOf(info.elementAt(1))+"_"+ans_inxArr[j]);
											
//											out.println("선택답"+option4_ans);
											String ans = ans_inxArr[j] ;
											String info_order = "";
											//int result2 = subjectbean.insert_info2(sub_idx ,question_idx ,info_order ,info_etc(예문의 답) , user_idx , ans(예문번호), "");
											int result2 = subjectbean.insert_info2(sub_idx ,question_idx ,info_order ,option4_ans, user_idx ,ans , "");
										}
									}
							}
							if (info.elementAt(0).equals("option3")) {   // 채크박스 인경우
									String[] ans_inxArr = request.getParameterValues(String.valueOf(info.elementAt(1)));
									if (ans_inxArr != null && ans_inxArr.length > 0) {

										for (int j=0; j < ans_inxArr.length; j++) {
//											out.println("문제번호:"+info.elementAt(1)+":답"+ans_inxArr[j]+":");
											String question_idx = String.valueOf(info.elementAt(1));
											String ans = ans_inxArr[j];
											String info_order = "";
												 String order_ans = info.elementAt(1)+"_order_"+ans_inxArr[j];
												 if ( request.getParameter(order_ans) != null && request.getParameter(order_ans).length() > 0 ) {
													 String order_ans_ = request.getParameter(order_ans);
//													 out.println("기타답변:"+order_ans_);
													 info_order = order_ans_;
												 }
												 int result2 = subjectbean.insert_info2(sub_idx ,question_idx ,info_order ,info_etc , user_idx , ans , "");
										}
									}
							}
				}  else {    //일반유형, 텍스트 입력 값인경우
					String bb = request.getParameter(Q_no);
					if (bb != null && bb.length() > 0) {
//						out.println("문제번호:"+Q_no+":선택답:"+bb);
						String question_idx = Q_no;		// 문제 번호
						String ans = bb;				// 답
						String info_order  = "";

						String order_ans = Q_no+"_order_"+bb;
						 if ( request.getParameter(order_ans) != null && request.getParameter(order_ans).length() > 0 ) {
							 String order_ans_ = request.getParameter(order_ans);
//							 out.println("기타답변:"+order_ans_);  // 정답을 선택했을 경우만 파라메타 값이 있음
							 info_order = order_ans_;
														 
						 }
						 String ans_right = subjectbean.getAns_num(question_idx);

//						 out.println("==정답=="+ans_right);
//						 out.println("=선택답="+ans);
//						 out.println("문제번호:"+question_idx);
							if(ans_right != null && ans_right.equals(ans)){
								point ++;  // 이벤트 일경우 점수 저장 
						}
						 int result2 = subjectbean.insert_info2(sub_idx ,question_idx ,info_order ,info_etc , user_idx , ans , "");

					}
					
				}
 			}

		}

		if ( sub_flag.equals("E") ){
			int result3 = subjectbean.insert_point(user_idx,point);
//			out.println(point);
		}
	}

			out.println("<SCRIPT LANGUAGE='JavaScript'>");
			out.println("alert('설문에 참여해 주셔서 감사합니다.')");
			out.println("self.close();");
			out.println("</SCRIPT>");
%>