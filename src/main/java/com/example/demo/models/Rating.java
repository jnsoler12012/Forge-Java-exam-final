package com.example.demo.models;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "ratings")
public class Rating {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String name;

	private int score;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "program_id")
	private Program program;

	@Column(updatable = false)
	private Date createdAt;
	private Date updatedAt;

	@PrePersist
	public void onCreate() {
		this.createdAt = new Date();
	}

	@PreUpdate
	public void onUpdate() {
		this.updatedAt = new Date();
	}
}
