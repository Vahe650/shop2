package ru.savshop.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.support.ConnectionFactoryRegistry;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import ru.savshop.shop.model.Gender;
import ru.savshop.shop.model.User;
import ru.savshop.shop.model.UserType;
import ru.savshop.shop.repository.CountryRepository;
import ru.savshop.shop.repository.UserRepository;


import javax.inject.Inject;
import javax.servlet.MultipartConfigElement;
import java.util.Properties;

@SpringBootApplication
@EnableAsync
@PropertySource("classpath:application.properties")



public class ShopApplication  implements CommandLineRunner {

    @Value("${gmail.email}")
    private String email;
    @Value("${gmail.password}")
    private String password;



    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CountryRepository countryRepository;
    @Inject
    private Environment environment;



    public static void main(String[] args) {
        SpringApplication.run(ShopApplication.class, args);
    }

    @Bean
    public ViewResolver internalResourceViewResolver() {
        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/");
        bean.setSuffix(".jsp");
        return bean;
    }


    @Bean(name = "mailSender")
    public JavaMailSender getJavaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setUsername(email);
        mailSender.setPassword(password);
        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");
        return mailSender;
    }


    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setMaxFileSize("124MB");
        factory.setMaxRequestSize("124MB");
        return factory.createMultipartConfig();
    }



    @Override
    public void run(String... strings) throws Exception {
        String email = "admin@mail.com";
        User oneByEmail = userRepository.findOneByEmail(email);
        if (oneByEmail == null) {
            userRepository.save(User.builder()
                    .email(email)
                    .password(new BCryptPasswordEncoder().encode("simonyan"))
                    .name("admin")
                    .surname("admin")
                    .country(countryRepository.findById(12).get())
                    .verify(true)
                    .token("")
                    .type(UserType.ADMIN)
                    .gender(Gender.MALE)
                    .build());
        }
    }

}
