package ru.savshop.shop.security;

import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.stereotype.Service;
import ru.savshop.shop.model.Gender;
import ru.savshop.shop.model.User;
import ru.savshop.shop.model.UserType;
import ru.savshop.shop.repository.CountryRepository;
import ru.savshop.shop.repository.UserRepository;


@Service
public class FacebookConnectionSignup implements ConnectionSignUp {
 
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CountryRepository countryRepository;




    @Override
    public String execute(Connection<?> connection) {
        Facebook facebook = (Facebook) connection.getApi();
        String [] fields = { "id", "about", "age_range", "birthday", "context", "cover", "currency", "devices",
                "education", "email", "favorite_athletes", "favorite_teams", "first_name", "gender", "hometown",
                "inspirational_people", "installed", "install_type", "is_verified", "languages", "last_name", "link",
                "locale", "location", "meeting_for", "middle_name", "name", "name_format", "political", "quotes", "payment_pricepoints",
                "relationship_status", "religion", "security_settings", "significant_other", "sports", "test_group", "timezone", "third_party_id",
                "updated_time", "verified",
                "video_upload_limits", "viewer_can_send_gift", "website", "work"};
        org.springframework.social.facebook.api.User userProfile = facebook.fetchObject("me", org.springframework.social.facebook.api.User.class, fields);
        User user=new User();
        user.setEmail(userProfile.getLastName().concat("@gmail.com"));
        user.setName(userProfile.getFirstName());
        user.setSurname(userProfile.getLastName());
        user.setPassword(new BCryptPasswordEncoder().encode(userProfile.getLastName()));
        user.setPicUrl(connection.getImageUrl());
        user.setCountry(countryRepository.findOne(12));
        user.setType(UserType.FB_USER);
        user.setGender(Gender.MALE);
        user.setVerify(true);
        userRepository.save(user);
        return user.getEmail();
    }
}