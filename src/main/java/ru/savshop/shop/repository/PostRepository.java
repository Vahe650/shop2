package ru.savshop.shop.repository;

        import org.springframework.data.jpa.repository.JpaRepository;
        import org.springframework.data.jpa.repository.Query;
        import org.springframework.data.repository.query.Param;
        import ru.savshop.shop.model.Category;
        import ru.savshop.shop.model.Picture;
        import ru.savshop.shop.model.Post;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Integer> {

    List<Post> findAllByUserId(int id);



    @Query(value = "SELECT * FROM Post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE WHERE post.title " +
            " LIKE lower(concat('%',:searchTerm,'%'))" +
            " ORDER BY post.`view` DESC", nativeQuery = true)
    List<Post> findPostsByTitleLike(@Param("searchTerm") String find);

    @Query(value = "SELECT * FROM post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE" +
            "  WHERE category_id=:id ORDER BY view DESC", nativeQuery = true)
    List<Post> findPostsByCategoryIdOrderByViewDesc(@Param("id") int id);

    Post findPostsById(int id);

    Post findOneByPicturesId(Picture picture);

    @Query(value = "SELECT * FROM post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE" +
            "  WHERE category_id=:id AND price BETWEEN :firstParam AND :secondParam ORDER BY view", nativeQuery = true)
    List<Post> betweenPrice(@Param("firstParam") double firstParam, @Param("secondParam") double secondParam, @Param("id") int id);

    @Query(value = "SELECT * FROM  post JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE  ORDER BY post.`id` LIMIT 4 ", nativeQuery = true)
    List<Post> lastFour();

    @Query(value = "SELECT * FROM Post  JOIN USER ON user.`id`=post.`user_id` AND user.`verify`=TRUE", nativeQuery = true)
    List<Post> findByUserVerify();
}
