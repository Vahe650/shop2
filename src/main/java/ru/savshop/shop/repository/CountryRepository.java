package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.savshop.shop.model.Category;
import ru.savshop.shop.model.Country;

public interface CountryRepository extends JpaRepository<Country, Integer>{
//    Category findById (int id);
}
