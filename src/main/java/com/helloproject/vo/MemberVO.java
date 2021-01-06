package com.helloproject.vo;

import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String memberId;
	private String memberPass;
	private String memberName;
}
