package ru.savshop.shop.security;

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
        String [] fields = { "id", "about","address", "age_range", "birthday",  "cover", "currency", "devices",
                "education", "email", "favorite_athletes", "favorite_teams", "first_name", "gender", "hometown",
                "inspirational_people", "installed", "install_type","interested_in",  "languages", "last_name", "link",
                "locale", "location",  "middle_name", "meeting_for", "name", "name_format", "political", "quotes",
                "relationship_status", "religion", "security_settings", "significant_other", "sports", "test_group",  "third_party_id","timezone",
                "updated_time", "verified",
               "viewer_can_send_gift", "website", "work"};
        org.springframework.social.facebook.api.User userProfile = facebook.fetchObject("me", org.springframework.social.facebook.api.User.class, fields );
        User user=new User();
        user.setEmail(userProfile.getLastName().concat("@gmail.com"));
        user.setName(userProfile.getFirstName());
        user.setSurname(userProfile.getLastName());
        user.setPassword(new BCryptPasswordEncoder().encode(userProfile.getLastName()));
        user.setPicUrl(connection.getImageUrl());
        user.setCountry(countryRepository.findById(12).get());
        user.setType(UserType.FB_USER);
        user.setGender(Gender.MALE);
        user.setVerify(true);
        userRepository.save(user);
        return user.getEmail();
    }

}