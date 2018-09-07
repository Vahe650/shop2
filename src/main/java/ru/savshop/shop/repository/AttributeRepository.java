package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.savshop.shop.model.Attributes;
import ru.savshop.shop.model.Category;

import java.util.List;

public interface AttributeRepository extends JpaRepository<Attributes, Integer> {
    List<Attributes> findAllByCategory (Category category);
}
