package kr.bit.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;

import lombok.Data;

@Entity  // DataBase의 Table
@Data
public class Member {
    
	@Id // PK
	private String username; // ID
	private String password;
	private String name;
	@Enumerated(EnumType.STRING)
	private Role role;
	private boolean enabled; // true, false 계정 활성화/비활성화
}