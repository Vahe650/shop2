package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.savshop.shop.model.Category;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
    Category findCategoryById (int id);
}
