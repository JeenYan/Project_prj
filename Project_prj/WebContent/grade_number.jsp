<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.concurrent.ExecutionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
public int getGrade(int user_point){
	String line = "";
	int grade = 1;
	BufferedReader br = null;
	
	try{
    br = new BufferedReader(new FileReader("C:\\dev\\workspace\\Project_prj\\WebContent\\grade.txt"));
   
    while((line = br.readLine()) != null){
            if(Integer.parseInt(line.split(",")[1])<=user_point && user_point <=Integer.parseInt(line.split(",")[2])){
         	   grade = Integer.parseInt(line.split(",")[0]);
            }//end if
    }//end while				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(br != null) try{br.close(); } catch(IOException h){h.printStackTrace();}
	}
    
    return grade;
}
%>
