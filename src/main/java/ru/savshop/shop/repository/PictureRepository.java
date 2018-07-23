package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.savshop.shop.model.Picture;

public interface PictureRepository extends JpaRepository<Picture, Integer> {

}
