package ru.savshop.shop.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Size;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "user",uniqueConstraints = {
        @UniqueConstraint(columnNames = {"email"}) })

public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column
    private int id;
    @Column
    @NotEmpty(message = "Name can't be empty")
    private String name;
    @Column
    @NotEmpty(message = "Surname can't be empty")
    private String surname;
    @Column(unique=true)
    @NotEmpty(message = "Email can't be empty")
    private String email;
    @Column
    private String password;
    @Transient
    @Size(message = "password size must be beetween 5-15",min = 5, max = 15)
    private String confirmPassword;
    @Column (name = "user_pic_pat")
    private String picUrl;
    @ManyToOne
    private Country country;
    @Column(name = "tel_1")
    private String tel1;
    @Column(name = "tel_2")
    private String tel2;
    @Column
    @Enumerated(EnumType.STRING)
    private UserType type;
    @Column
    @Enumerated(EnumType.STRING)
    private Gender gender ;
    @Column(name = "register_time")
    private String timeStamp;
    @Column
    private String token;
    @Column
    private boolean verify;
}
