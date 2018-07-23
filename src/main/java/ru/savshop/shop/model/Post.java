package ru.savshop.shop.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.NumberFormat;

import javax.persistence.*;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "post")
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column
    private int id;
    @Column
    private String title;
    @Column
    private String description;
    @Column
    @NumberFormat
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
