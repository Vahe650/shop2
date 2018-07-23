package ru.savshop.shop.security;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;


public class CurrentUser extends User{

    private ru.savshop.shop.model.User user;

    public CurrentUser(ru.savshop.shop.model.User user) {
        super(user.getEmail(), user.getPassword(),user.isVerify(),true,true,
                true, AuthorityUtils.createAuthorityList(user.getType().name()));

        this.user = user;
    }

    public ru.savshop.shop.model.User getUser() {
        return user;
    }
    public int getId(){
        return user.getId();
    }
}
