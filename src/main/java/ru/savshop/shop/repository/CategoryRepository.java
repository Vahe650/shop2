package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import ru.savshop.shop.model.Category;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
    Category findCategoryById (int id);
    @Query(value = "SELECT * FROM category c JOIN category d  ON  c.`parent_id`=d.`id`  ORDER BY c.`parent_id` ",nativeQuery = true)
    List<Category> allCategoriesOrOrderByParentId();
}
