package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.savshop.shop.model.Post;
import ru.savshop.shop.model.User;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Integer> {

    User findOneByEmail(String email);


    @Query("SELECT t FROM User t WHERE LOWER(t.email) LIKE LOWER(CONCAT('%', :searchItem, '%')) ORDER BY t.email ASC\n" + "  ")
    User findUserByEmailLike(@Param("searchItem") String find);

   ;
    @Query("SELECT u FROM User  u WHERE LOWER(u.name) LIKE LOWER(CONCAT('%', :searchUser, '%')) OR LOWER(u.email) " +
            "LIKE LOWER(CONCAT('%', :searchUser, '%')) ORDER BY u.email ASC\n" + "  ")
    List<User> findUsersByTitleLike(@Param("searchUser") String find);
}
