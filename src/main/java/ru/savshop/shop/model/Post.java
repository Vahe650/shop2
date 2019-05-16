package ru.savshop.shop.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;

import javax.persistence.*;
import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "post" )
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;
    @Column
//    @NotEmpty(message = "Name can't be empty")
    private String title;
    @Column
//    @NotEmpty(message = "Description can't be empty")
    private String description;
    @Column
    @NumberFormat
    @DecimalMax(value = "10000000000.0",message = "price must be untill 10.000.000.000")@DecimalMin(value = "0.0",message = "price cant be 0")
    private double price;
    @Column
    private String timestamp;
    @ManyToOne
    private User user;
    @ManyToOne
    private Category category;
    @ManyToOne
    private Country country;
    @OneToMany (mappedBy = "post", cascade = CascadeType.ALL)
    private List<Picture> pictures;
    @Transient
    private List<AttributeValue> attributeValues;
    @Transient
    private List<Attributes> atributes;
    @Column
    private int view;
}
