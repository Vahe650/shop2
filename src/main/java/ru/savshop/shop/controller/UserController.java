package ru.savshop.shop.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.savshop.shop.mail.EmailServiceImp;
import ru.savshop.shop.model.Post;
import ru.savshop.shop.model.User;
import ru.savshop.shop.repository.CategoryRepository;
import ru.savshop.shop.repository.CountryRepository;
import ru.savshop.shop.repository.PostRepository;
import ru.savshop.shop.repository.UserRepository;
import ru.savshop.shop.security.CurrentUser;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

@Controller(value = "/user")
public class UserController {
    @Autowired
    private EmailServiceImp emailServiceImp;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private CountryRepository countryRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private UserRepository userRepository;
    @Value("${shop.postpic.upload.path}")
    private String postImageUploadPath;
    @Value("${shop.userpic.upload.path}")
    private String userPostImageUploadPath;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(ModelMap map) {
        map.addAttribute("allcountry", countryRepository.findAll());
        return "login";
    }

    @RequestMapping(value = "/deletePost")
    public String del(@RequestParam("id") int id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            Post post = postRepository.findById(id).get();
            if (post.getUser().getId() == currentUser.getId()) {
                postRepository.delete(post);
            } else {
                return "redirect:/accessError";
            }
            return "redirect:/userProfileDetail?id=" + currentUser.getId();
        }
        return "redirect:/login";
    }


    @RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
    public String update(@Valid @ModelAttribute("add") User user, BindingResult result,
                         @RequestParam(value = "existingPassword", required = false) String existingPassword,
                         @RequestParam(value = "picture") MultipartFile file) throws IOException {
        User existUser = userRepository.findById(user.getId()).get();
        String dbPassword = existUser.getPassword();
        if (passwordEncoder.matches(existingPassword, dbPassword)) {
            if (file.isEmpty()) {
                user.setPicUrl(existUser.getPicUrl());
            } else {
                String picName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                File picture = new File(userPostImageUploadPath + picName);
                file.transferTo(picture);
                user.setPicUrl(picName);
            }
            user.setPassword(passwordEncoder.encode(existingPassword));
            user.setVerify(true);
            user.setType(existUser.getType());
            if (user.getGender()==null) {
                user.setGender(existUser.getGender());
            }
            user.setToken("");
            StringBuilder sb = new StringBuilder();
            if (result.hasErrors()) {
                for (ObjectError objectError : result.getAllErrors()) {
                    sb.append(objectError.getDefaultMessage()).append("<br>");
                }
                return "redirect:/updateUser?message=" + sb.toString();
            }
            userRepository.save(user);
            return "redirect:/updateUser?id="+user.getId();
        }
        return "redirect:/userUpdatePassError";
    }

    @RequestMapping(value = "/updatePass", method = RequestMethod.POST)
    public String updatePass(@ModelAttribute("add") User user,
                             @RequestParam(value = "existingPassword", required = false) String existingPassword,
                             @RequestParam(name = "one") String one, @RequestParam(name = "two") String two) {
        CurrentUser currentUser = (CurrentUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (two.equals(one)) {
            String dbPassword = userRepository.getOne(user.getId()).getPassword();
            if (passwordEncoder.matches(existingPassword, dbPassword)) {
                User user1 = userRepository.getOne(currentUser.getId());
                user1.setPassword(passwordEncoder.encode(one));
                userRepository.save(user1);
                return "redirect:/userProfileDetail?id=" + currentUser.getId();
            }
        }
        return "redirect:/userPassError";
    }

    @RequestMapping(value = "/updateUserPassword")
    public String updateUserPassword(ModelMap map, @ModelAttribute("add") User user1,
                                     @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            map.addAttribute("current", userRepository.findById(user.getId()).get());
        }
        return "userPassUpdate";
    }

    @RequestMapping(value = "/userPassError")
    public String userPassError(ModelMap modelMap, @ModelAttribute("add") User user1,
                                @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findById(user.getId()).get());
            modelMap.addAttribute("errorMessage", "Password are entered incorrectly!\n Please try again");
        }
        return "userPassUpdate";
    }

    @RequestMapping(value = "/updateUser")
    public String up(ModelMap map, @RequestParam(name = "message", required = false) String message, @ModelAttribute("add") User ser1,
                     @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            map.addAttribute("message", message != null ? message : "");
            User user = ((CurrentUser) userDetails).getUser();
            map.addAttribute("current", userRepository.findById(user.getId()).get());
            map.addAttribute("allcountry", countryRepository.findAll());
        }
        return "userUpdate";
    }

    @RequestMapping(value = "/mailSender")
    public String send(@ModelAttribute(name = "user") User user,
                       @RequestParam(name = "body", required = false) String body,
                       @RequestParam(name = "text", required = false) String text,
                       @RequestParam(name = "userName", required = false) String userName,
                       @RequestParam(name = "to", required = false) String to) {
        emailServiceImp.sendSimpleMessage(to, "Hello " + userName, "you have a message from  " + body + "\n" + text);
        return "redirect:/";
    }


    @RequestMapping(value = "/userProfileDetail", method = RequestMethod.GET)
    public String userPosts(ModelMap modelMap, @RequestParam("id") int id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findById(currentUser.getId()).get());
            modelMap.addAttribute("posts", postRepository.findAllByUserId(currentUser.getId()));
            modelMap.addAttribute("allposts", postRepository.findAll());
            modelMap.addAttribute("four", postRepository.lastFour());
            modelMap.addAttribute("allCategories", categoryRepository.findAll());
        }
        return "userProfile";
    }

    @RequestMapping(value = "/userUpdatePassError")
    public String pass(ModelMap modelMap, @ModelAttribute("add") User user1,
                       @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findById(user.getId()).get());
            modelMap.addAttribute("allcountry", countryRepository.findAll());
            modelMap.addAttribute("message", "Password are entered incorrectly!\n Please try again");
        }
        return "userUpdate";
    }

    @RequestMapping(value = "/user/image", method = RequestMethod.GET)
    public void getImageAsByteArray(HttpServletResponse response, @RequestParam("fileName") String fileName) throws
            IOException {
        InputStream in = new FileInputStream(userPostImageUploadPath + fileName);
        response.setContentType(MediaType.IMAGE_JPEG_VALUE);
        IOUtils.copy(in, response.getOutputStream());
    }


}
