package com.helloproject.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoAPI {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// ***카카오 로그인 : 인가코드 + 토큰받기 2가지가 필요
	// 1. 이 주소(인가 코드를 받을 수 있는 request)를 치면 내가 설정한 redirect_url로 인가코드(code)를 response로 발급 받을 수 있다.
	// http://kauth.kakao.com/oauth/authorize?client_id=6b650553a43ed59a1a4f1f1211dbc9b0&
	// redirect_uri=http://localhost:8282/login&response_type=code
	// 2. 그 code를 넣어 토큰받기를 한 과정이 getAccessToken()의 역할이다.
	
	
	public String getAccessToken(String authorize_code) {
		
		// 토큰 받기
		// 필수 파라미터 값들을 담아 POST로 요청합니다. 
		// 요청 성공 시, 응답은 JSON 객체로 Redirect URI에 전달되며 두 가지 종류의 토큰 값과 타입, 초 단위로 된 만료 시간을 포함하고 있습니다.
		// POST /oauth/token HTTP/1.1
		// Host: kauth.kakao.com
		// Content-type: application/x-www-form-urlencoded;charset=utf-8
		
		String access_Token = ""; // 로그인성공시 부여되는 짧은 수명의 토큰
		String refresh_Token = ""; // 로그인성공시 부여되는 긴 수명의 토큰
		String reqURL = "https://kauth.kakao.com/oauth/token"; // Host + POST
		
		try {
			// 이 순서가 java network의 stereo이다.
			// get방식의 경우 인코딩된 데이터를 파라미터형식으로 url뒤에 붙여서 보내면되는데
			// post방식의 경우 스트림을통해 파라미터를 전송해야하므로 outputStream을 구해야한다.
			URL url = new URL(reqURL); // 자원에 대한 URL객체 생성, 자바로 사이트데이터를 읽기위함
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // open~은 자원을 읽을수있게 열어두는 기능		
			conn.setRequestMethod("POST"); // 이 데이터를 post방식으로 전송
			conn.setDoOutput(true); // URLConnection의 출력 스트림을 사용할지의 여부
			
			// BufferedWriter : 버퍼를 사용하여 쓴다. 버퍼로 출력하면 출력 기능면에서 효율적이다.
			// OutputStreamWriter : 문자 출력 스트림을 바이트 스트림으로 변환시키는 역할을 하는 보조 스트림
			// OutputStream : Request Body에 Data를 담기위해 OutputStream객체를 생성. 외부로 데이터 전송
			// 결국 request body에 담을 데이터를 문자 출력 스트림으로 생성하고 버퍼로 출력하겠다고 지정한 것.
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			
			// StringBuilder : String a = "abc", String b = "def"가 있을때
			// a+b의 연산을 반복하다 보면 메모리할당과 해제를 반복하기 때문에 성능이 나빠진다.
			// StringBuilder는 문자열을 더할때 새로운 객체가 아니라 기존의 데이터에 더해서 효율적이다.
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code"); // append는 문자열을 더함
            sb.append("&client_id=6b7c2217bf1a0a9a6df66953a236f6dc");
            sb.append("&redirect_uri=http://localhost:8282/userCheck");
            sb.append("&code=" + authorize_code);
            
            bw.write(sb.toString()); //BufferedWriter방식으로 위 스트링을 쓰겠다.
            bw.flush(); // 플러시는 하겠다는 의미
                  
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            // BufferedReader : 버퍼를 사용하여 읽는다.
            // InputStreamReader : 바이트 스트림을 문자 출력 스트림으로 변환시키는 역할을 하는 보조 스트림
            // InputStream : 입력스트림으로 외부로부터 내용을 읽어 들임
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
            	result += line;
            }
            System.out.println("response body : " + result);	
            // 현재 json형식으로 되어 있음
			
            // json형식을 파싱하는 Gson(Google Json)
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
      
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return access_Token;	
	}

	public HashMap<String, Object> getUserInfo(String access_Token) {

		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		
		try {
	        URL url = new URL(reqURL);
	        
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        
	        //요청에 필요한 Header에 포함될 내용
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("************************");
	        System.out.println("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	       
	        String line = "";
	        String result = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        System.out.println("response body : " + result);
	        
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        
	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        
	        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	        String email = kakao_account.getAsJsonObject().get("email").getAsString();
	       
	        System.out.println("properties : " + properties);

	        userInfo.put("nickname", nickname);
	        userInfo.put("email", email);
	        
	    } catch (IOException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
		return userInfo;		
	}
	
	public void kakaoLogout(String access_Token) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String result = "";
			String line = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			
			System.out.println(result);			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}