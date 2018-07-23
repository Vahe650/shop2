package ru.savshop.shop.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "atributes")

public class Attributes {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column
    private int id;
    @Column
    private String name;
    @ManyToOne
    private Category category;

//    @ManyToMany(mappedBy = "atributes")
//    private List<Post> posts;

    public Attributes(int one) {
        this.id = one;
    }
}
