package com.helloproject.service;


import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.helloproject.mapper.BoardMapper;
import com.helloproject.vo.BoardVO;
import com.helloproject.vo.Criteria;
import com.helloproject.vo.MemberVO;

@Service
public class BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	public String now() throws Exception {
		return boardMapper.now();
	}
	

	// 로그인
	public MemberVO memberLogin(MemberVO memberVO) throws Exception {
		return boardMapper.memberLogin(memberVO);
	}
	
	// 유저체크
	public MemberVO userCheck(MemberVO memberVO) throws Exception {
		return boardMapper.userCheck(memberVO);
	}
	
	
	// 아이디체크
	public int idCheck(String memberId) throws Exception {
		return boardMapper.idCheck(memberId);
	}
	
	public void kakaoLogin(Map<String, Object> data) throws Exception {
		boardMapper.kakaoLogin(data);
	}
	

	// 회원가입
	public void memberRegister(MemberVO memberVO) throws Exception {
		boardMapper.memberRegister(memberVO);
	}
	
	// 회원정보 수정 - 세션 가져오기
	public MemberVO membermodifyGET(String memberId) throws Exception {
		return boardMapper.memberModifyGET(memberId);
	}
	
	// 회원정보 수정 
	public void memberModifyPOST(MemberVO memberVO) throws Exception {
		boardMapper.memberModifyPOST(memberVO);
	}
	
	// 회원 탈퇴
	public void memberDelete(MemberVO memberVO) throws Exception {
		boardMapper.memberDelete(memberVO);
	}
	
	// 게시판
	public void boardWrite(BoardVO boardVO) throws Exception {
		boardMapper.boardWrite(boardVO);
	}

	public List<Map<String, Object>> boardList(Criteria cri) throws Exception {
		return boardMapper.boardList(cri);
	}
	
	public int boardListCnt() throws Exception {
		return boardMapper.boardListCnt();
	}
	
	
	public BoardVO boardRead(int num) throws Exception {
		return boardMapper.boardRead(num);
	}
	
	public void boardModify(BoardVO boardVO) throws Exception {
		boardMapper.boardModify(boardVO);
	}
	
	public void boardModifyForm(int num) throws Exception {
		boardMapper.boardModifyForm(num);
	}
	
	public void boardDelete(int num) throws Exception {
		boardMapper.boardDelete(num);
	}
}
