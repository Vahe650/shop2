package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.savshop.shop.model.Picture;
import ru.savshop.shop.model.Post;

public interface PostPicRepository extends JpaRepository<Picture, Integer> {
}
