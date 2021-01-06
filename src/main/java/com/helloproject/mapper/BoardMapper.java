package com.helloproject.mapper;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.helloproject.vo.BoardVO;
import com.helloproject.vo.Criteria;
import com.helloproject.vo.MemberVO;

@Repository
public interface BoardMapper {
	
	public String now() throws Exception;
	
	// 로그인
	public MemberVO memberLogin(MemberVO memberVO) throws Exception;
	
	// 유저체크
	public MemberVO userCheck(MemberVO memberVO) throws Exception;
	
	// 아이디체크
	public int idCheck(String memberId) throws Exception;
	
	// 카카오로그인
	public void kakaoLogin(Map<String, Object> data) throws Exception;
	
	// 회원가입
	public void memberRegister(MemberVO memberVO) throws Exception;
	
	// 회원정보 수정 - 세션 가져오기
	public MemberVO memberModifyGET(String memberId) throws Exception;
	
	// 회원정보 수정 
	public void memberModifyPOST(MemberVO memberVO) throws Exception;
	
	// 회원 탈퇴
	public void memberDelete(MemberVO memberVO) throws Exception;

	
	// 게시판
	public void boardWrite(BoardVO boardVO) throws Exception;
	
	public List<Map<String, Object>> boardList(Criteria cri) throws Exception;
	
	public int boardListCnt() throws Exception;
	
	public BoardVO boardRead(int num) throws Exception;
	
	public void boardModify(BoardVO boardVO) throws Exception;

	public void boardModifyForm(int num) throws Exception;

	public void boardDelete(int num) throws Exception;
}
