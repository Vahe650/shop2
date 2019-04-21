package ru.savshop.shop.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.social.UserIdSource;
import org.springframework.social.config.annotation.ConnectionFactoryConfigurer;
import org.springframework.social.config.annotation.EnableSocial;
import org.springframework.social.config.annotation.SocialConfigurerAdapter;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.jdbc.JdbcUsersConnectionRepository;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;

import javax.inject.Inject;
import javax.inject.Named;
import javax.sql.DataSource;

@Configuration
@EnableSocial
public class SocialConfig extends SocialConfigurerAdapter {

protected static final String FACEBOOK_APP_ID = "spring.social.facebook.appId";
protected static final String FACEBOOK_APP_SECRET = "spring.social.facebook.appSecret";


private DataSource dataSource;

@Inject
public void setDataSource(@Named("dataSource") DataSource dataSource) {
    this.dataSource = dataSource;
}

@Override
public void addConnectionFactories(ConnectionFactoryConfigurer connectionFactoryConfigurer, Environment env) {
    connectionFactoryConfigurer.addConnectionFactory(getFacebookConnectionFactory(env));
}

@Override
public UserIdSource getUserIdSource() {
    return new AuthenticationNameUserIdSource();
}

@Override
public UsersConnectionRepository getUsersConnectionRepository(ConnectionFactoryLocator connectionFactoryLocator) {
    return new JdbcUsersConnectionRepository(dataSource, connectionFactoryLocator, Encryptors.noOpText());
}


protected final FacebookConnectionFactory getFacebookConnectionFactory(Environment env) {
    String appId = env.getProperty(FACEBOOK_APP_ID);
    String appSecret = env.getProperty(FACEBOOK_APP_SECRET);



    return new FacebookConnectionFactory(appId, appSecret);
}





protected DataSource getDataSource() {
    return dataSource;
}}