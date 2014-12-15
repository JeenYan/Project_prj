<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="javax.naming.SizeLimitExceededException"%>
<%@page import="dao.memberDAO"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="vo.memberVO"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 요청방식이 파일업로드에 적합한 방식인지를 판단
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	String fileName = "";
	if (isMultipart) {
		try {
			DiskFileItemFactory factory = new DiskFileItemFactory();

			// file import 임의 설정함. 안되면 수정할 것
			File repository = new File(
					"C:/dev/workspace/Project_prj/WebContent/images/member/photo/");
			// Set factory constraints
			// 메모리에 끊어서 저장할 최대크기 설정 1Mbyte
			factory.setSizeThreshold(1024 * 1024 * 5);
			factory.setRepository(repository);// 절대경로

			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);

			// Set overall request size constraint
			// 업로드 파일의 최대 크기 설정 : 5Mbyte
			upload.setSizeMax(5 * 1024 * 1024);

			// Parse the request
			// 요청처리 객체로부터 form 객체 파일 얻기
			// Form Contorl이 FileItem 클래스에 저장 된다
			List<FileItem> items;
			items = upload.parseRequest(request);
			memberVO mv = new memberVO();
			// 업로드된 item(Form Control)의 처리
			Iterator<FileItem> iter = items.iterator();
			// 파라메터가 끝날 때까지 반복
			String phone = "";
			String address = "";
			while (iter.hasNext()) {
				FileItem item = iter.next();
				if (item.isFormField()) {

					String name = item.getFieldName();
					String value = new String(item.getString()
							.getBytes("8859_1"), "UTF-8");
					// 숫자예외줄 것
					if (item.getFieldName().equals("id")) {
						fileName="testSES5";
						mv.setMemid(fileName);
					} else if (item.getFieldName().equals("pass01")) {
						mv.setMempass(new String(item.getString()
								.getBytes("8859_1"), "UTF-8"));
					} else if (item.getFieldName().equals("nicname")) {
						mv.setMemnic("what");
					} else if (item.getFieldName().equals("name")) {
						mv.setMemname(new String(item.getString()
								.getBytes("8859_1"), "UTF-8"));
					} else if (item.getFieldName().equals("joomin")) {
						mv.setMemjoomin(Integer.valueOf(item
								.getString()));
					}else if(item.getFieldName().equals("add01")){
						address += new String(item.getString().getBytes("8859_1"), "UTF-8") + ",";
					}else if(item.getFieldName().equals("add02")){
						address += new String(item.getString().getBytes("8859_1"), "UTF-8") + ",";
					}else if (item.getFieldName().equals("add03")) {
						address += new String(item.getString().getBytes("8859_1"), "UTF-8");
						//mv.setMemaddress(item.getString());
						mv.setMemaddress(address);
					} else if (item.getFieldName()
							.equals("phoneSelect")) {
						phone += item.getString() + "-";
					} else if (item.getFieldName().equals("phone01")) {
						phone += item.getString() + "-";
					} else if (item.getFieldName().equals("phone02")) {
						phone += item.getString();
						mv.setMemphone(phone);
					} else if (item.getFieldName().equals("email")) {
						mv.setMememail(new String(item.getString()
								.getBytes("8859_1"), "UTF-8"));
					} else if (item.getFieldName().equals("point")) {
						mv.setMempoint(Integer.valueOf(item.getString()));
					} else if (item.getFieldName().equals("hint")) {
						mv.setMemask("A");
					} else if (item.getFieldName().equals("answer")) {
						mv.setMemans(item.getString());
					}// end if

				} else {
					// out.println("파일 컨트롤");

					//String fieldName = item.getFieldName();
					fileName = item.getName();
					//String contentType = item.getContentType();
					//boolean isInMemory = item.isInMemory();
					//long sizeInBytes = item.getSize();
					// 업로드한 파일명과 저장할 경로를 파일클래스에 넣고
					 fileName = mv.getMemid()
							+ "."
							+ fileName.split("\\.")[fileName.split("\\.").length - 1]; 
					mv.setPhoto(fileName);

					memberDAO md = memberDAO.getInstance();
					boolean flag = md.insertMember(mv);
					if (flag) {
						File uploadedFile = new File(
								repository.getAbsolutePath() + "/"
										+ fileName);
						// 해당 폴더에 파일 생성
						item.write(uploadedFile);
					}//end if
				}// end if
			}// end while

			System.out.println(mv.getMemid() + "/" + mv.getMempass()
					+ "/" + mv.getMemnic() + "/" + mv.getMemname()
					+ "/" + mv.getMemjoomin() + "/"
					+ mv.getMemaddress() + "/" + mv.getMemphone() + "/"
					+ mv.getMememail() + "/" + mv.getMempoint() + "/"
					+ mv.getMemask() + "/" + mv.getMemans()+"/"+mv.getPhoto());
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	} else {
	}// end if
%>