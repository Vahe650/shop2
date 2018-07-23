package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.savshop.shop.model.AttributeValue;
import ru.savshop.shop.model.Post;

import java.util.List;

public interface AttribValueRepository extends JpaRepository<AttributeValue, Integer> {
    AttributeValue findAllById (int id);
    List<AttributeValue> findAllByPost(Post post);
}
