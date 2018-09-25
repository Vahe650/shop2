package ru.savshop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.savshop.shop.model.Category;
import ru.savshop.shop.model.Picture;
import ru.savshop.shop.model.Post;
import ru.savshop.shop.model.User;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Integer> {

    List<Post> findAllByUserId(int id);

    @Query(value = "SELECT * FROM Post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE WHERE post.title " +
            " like lower(concat('%',:searchTerm,'%'))" +
            " ORDER BY post.`view` desc", nativeQuery = true)
    List<Post> findPostsByTitleLike(@Param("searchTerm") String find);

    @Query(value = "SELECT * from post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE" +
            "  where category_id=:id ORDER By view DESC", nativeQuery = true)
    List<Post> findPostsByCategoryIdOrderByViewDesc(@Param("id") int id);
    @Query(value = "SELECT * from post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE" +
            "  where category_id=:id and price between :firstParam and :secondParam ORDER By view", nativeQuery = true)
    List<Post> betweenPrice(@Param("firstParam") double firstParam, @Param("secondParam") double secondParam, @Param("id") int id);

    @Query(value = "select * from  post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE  order by post.`id` Desc limit 4 ", nativeQuery = true)
    List<Post> lastFour();

    @Query(value = "SELECT * FROM Post  JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE ORDER BY post.`id` DESC ", nativeQuery = true)
    List<Post> findByUserVerify();
}
