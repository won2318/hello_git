<%@page import="com.vodcaster.multpart.MultipartRequest"%>
<%@ page contentType="text/html; charset=euc-kr"%>


<%-- File�� ����ϱ� ���ؼ� --%> 

<%@ page import="com.yundara.util.*" %>
<%-- Enumeration�� ����ϱ� ���Ͽ� --%>
<%@ page import="java.util.*" %>

<%@ page import="java.io.*" %>

<%
String filename = "";
String original ="";

//������ ���ε�Ǵ� ������ �����Ѵ�
String saveFolder="/vodman/editer/popup/upload";
String encType="euc-kr";//���ڵ� Ÿ��
int maxSize = 1*1024*1024;//�ִ� ���ε� �� ����ũ�� 1Mb
String qnacontent="";

ServletContext context =getServletContext();

//���� jsp�������� �� ���ø����̼ǻ��� �����θ� ���Ѵ�
String realFolder= context.getRealPath(saveFolder);
//out.println("the realpath is :" + realFolder + "<br>"); 

try{
	MultipartRequest multi = null;
	//������ ����� ������Ʈ�� �����ϰ� �� ������ �����Ѵ�
	//������ ���ϸ��� ������ �ִ� ��ü, �������� ������, �ִ���ε�� ���� ũ��, �����ڵ�,�⺻���� ����
	multi = new MultipartRequest(request, realFolder,maxSize, new DefaultFileRenamePolicyITNC21());
	qnacontent = multi.getParameter("uploadInputBox");
	//Form�� �Ķ���� ����� �����´�
	Enumeration params =multi.getParameterNames();

	//�Ķ���͸� ����Ѵ�
	while(params.hasMoreElements()){
		String name =(String)params.nextElement();//���۵Ǵ� �Ķ���� �̸�
		String value = multi.getParameter(name);//���۵Ǵ� �Ķ���Ͱ�
		//out.println(name +" = " +value + "<br>");
	}

	out.println("-----------------------------------------<br>");

	//���۵Ǵ� ���� ������ ������ ����Ѵ�
	Enumeration files = multi.getFileNames();
	
 	//���� ������ �ִٸ�
	while(files.hasMoreElements()){
		//input �±��� �Ӽ��� file �� �±��� name �Ӽ��� : �Ķ���� �̸�
		String name =(String)files.nextElement();
		
		//������ ����� ���� �̸�
		filename = multi.getFilesystemName(name);
		filename = filename.replace(" ","");
		
		//������ ������ ���� �̸�
		original = multi.getOriginalFileName(name);
		original = original.replace(" ","");
		
		//���۵� ������ ���� Ÿ��
		String type = multi.getContentType(name);
		
		//���۵� ���� �Ӽ��� file �� �±���  name �Ӽ����� �̿��� ������ ��ü ����
		File file = multi.getFile(name);


		//out.println("�Ķ���� �̸� : " +name +"<br>");
		//out.println("���� ���� �̸� : " +original +"<br>");
		//out.println("����� �̸� : " +filename +"<br>");
		//out.println("���� Ÿ�� : " +type +"<br>");

		if(file!=null){
			//out.println("ũ�� : " +file.length());
			//out.println("<br>");
		}
	}
}catch(IOException ioe){
	System.out.println(ioe);
}catch(Exception ex){
	System.out.println(ex);
}
%>

<html>
<head><title></title></head>
<body>
<script type="text/javascript">
try{
	parent.opener.parent.insertIMG('<%=saveFolder%>','<%=filename%>');
	parent.parent.test();
<%-- 	opener.parent.oEditors.getById['<%=qnacontent%>'].exec("SE_TOGGLE_IMAGEUPLOAD_LAYER");     --%>
} catch(e){
	alert(e);
}
</script>
</body>
</html>


