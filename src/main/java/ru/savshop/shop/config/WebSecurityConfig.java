package ru.savshop.shop.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.jdbc.JdbcUsersConnectionRepository;
import org.springframework.social.connect.web.ProviderSignInController;
import ru.savshop.shop.handler.CustomFailureHandler;
import ru.savshop.shop.security.FacebookConnectionSignup;
import ru.savshop.shop.security.FacebookSignInAdapter;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    @Qualifier("currentUserDetailService")
    private UserDetailsService userDetailsService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private ConnectionFactoryLocator connectionFactoryLocator;
    @Autowired
    private UsersConnectionRepository usersConnectionRepository;
    @Autowired
    private FacebookConnectionSignup facebookConnectionSignup;





    protected void configure(HttpSecurity http) throws Exception {

        http.csrf().
                disable()
                .exceptionHandling().accessDeniedPage("/accessError")
                .and()
                .formLogin()
                .loginPage("/login")
                .usernameParameter("email")
                .passwordParameter("password")
                .defaultSuccessUrl("/loginSuccess")
                .failureHandler(new CustomFailureHandler())
                .and()
                .rememberMe().and()
                .logout()
                .logoutSuccessUrl("/login")
                .and()
                .authorizeRequests()
                .antMatchers("/signin/**").permitAll()
                .antMatchers("/admin/**").hasAuthority("ADMIN")
                .antMatchers("/post", "/updatePost", "/updateUserPassword").hasAnyAuthority("USER","FB_USER")
                .antMatchers("/changeCategory", "/updateUser", "/userProfileDetail", "/addPost").hasAnyAuthority("ADMIN","USER","FB_USER")
                .anyRequest().permitAll();
        http.authorizeRequests().antMatchers("/siignin/facebook").access("hasRole('FB_USER')");
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder);
    }

    @Bean
    public PasswordEncoder encoder() {

        return new BCryptPasswordEncoder();
    }
    @Bean
    public ProviderSignInController providerSignInController() {
        ((JdbcUsersConnectionRepository) usersConnectionRepository)
                .setConnectionSignUp(facebookConnectionSignup);

        return new ProviderSignInController(
                connectionFactoryLocator,
                usersConnectionRepository,
                new FacebookSignInAdapter());
    }
}
