package ru.savshop.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.savshop.shop.mail.EmailServiceImp;
import ru.savshop.shop.model.*;
import ru.savshop.shop.repository.*;
import ru.savshop.shop.security.CurrentUser;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
public class AdminController {

    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private EmailServiceImp emailServiceImp;
    @Autowired
    private CountryRepository countryRepository;
    @Autowired
    private AttributeRepository attributeRepository;

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(ModelMap map) {
        map.addAttribute("category", new Category());
        map.addAttribute("allCategories", categoryRepository.findAll());
        map.addAttribute("country", new Country());
        map.addAttribute("allCountries", countryRepository.findAll());
        map.addAttribute("atribute", new Attributes());
        map.addAttribute("allAtributes", attributeRepository.findAll());
        map.addAttribute("allUsers", userRepository.findAll());
        return "adminPage";
    }

    @RequestMapping(value = "/admin/addCategory", method = RequestMethod.POST)
    public String adminPageAddCategory(@ModelAttribute(name = "category") Category category) {
        categoryRepository.save(category);
        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/addParrentCategoryAndAtribute", method = RequestMethod.POST)
    public String addParrentCategoryAndAtribute(@ModelAttribute(name = "category") Category category,
                                                @RequestParam("atribute") List<String> atributes) {
        categoryRepository.save(category);
        List<Attributes> attributesList = new LinkedList<>();
        for (String attribute : atributes) {
            Attributes atributes1 = new Attributes();
            atributes1.setCategory(category);
            atributes1.setName(attribute);
            attributeRepository.save(atributes1);
            attributesList.add(atributes1);
        }
        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/addCountry", method = RequestMethod.POST)
    public String adminPageAddcountry(@ModelAttribute(name = "country") Country country) {
        countryRepository.save(country);
        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/allUsers")
    public String all(ModelMap map) {
        map.addAttribute("allUsers", userRepository.findAll());
        map.addAttribute("allPosts", postRepository.findByUserVerify());
        return "viewUsers";
    }

    @RequestMapping(value = "/admin/deleteUser")
    public String delete(@RequestParam("id") int id) {
        userRepository.delete(id);
        return "redirect:/admin/searchUser";
    }

    @RequestMapping(value = "/admin/deletePost")
    public String del(@RequestParam("id") int id) {
        postRepository.delete(id);
        return "redirect:/admin/allUsers";
    }

    @RequestMapping(value = "/admin/searchUser", method = RequestMethod.GET)
    public String searchUser(ModelMap modelMap, @RequestParam(name = "search", required = false) String search, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findOne(currentUser.getId()));
        }
        modelMap.addAttribute("allPosts",postRepository.findByUserVerify());
        modelMap.addAttribute("four", postRepository.lastFour());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        modelMap.addAttribute("all", userRepository.findAll());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        List<User> userList = userRepository.findUsersByTitleLike(search);
        if (search != null && userList.isEmpty()) {
            modelMap.addAttribute("mess", "Search Result with " + "' " + search + " '" + " not Found");
        } else {
            modelMap.addAttribute("allUsers", userList);
        }
        return "searchUser";
    }


    @RequestMapping(value = "/blockUser")
    public String update(@RequestParam("id") int id) {
        User user = userRepository.findOne(id);
        if (user.isVerify()) {
            user.setVerify(false);
            user.setToken("");
            userRepository.save(user);
            String text = String.format("hello %s You are blocked and You can't visit to your profile. " +
                    "\n If You want to unblock Your profile please contact with Admin", user.getName());
            emailServiceImp.sendSimpleMessage(user.getEmail(), "OOPS", text);
        } else {
            user.setToken(UUID.randomUUID().toString());
            userRepository.save(user);
            String url = String.format("http://localhost:8080/unblockVerify?token=%s&email=%s", user.getToken(), user.getEmail());
            String text = String.format("hello %s you are unblocked, click " +
                    "on this link for visiting your profile %s", user.getName(), url);
            emailServiceImp.sendSimpleMessage(user.getEmail(), "Welcome...", text);
        }
        return "redirect:/admin/searchUser?search=" + user.getEmail();
    }

    @RequestMapping(value = "/unblockVerify", method = RequestMethod.GET)
    public String unblock(@RequestParam("token") String token, @RequestParam("email") String email) {
        User one = userRepository.findOneByEmail(email);
        if (one != null) {
            if (one.getToken() != null && one.getToken().equals(token)) {
                one.setToken("");
                one.setVerify(true);
                userRepository.save(one);
            }
        }
        return "redirect:/";

    }


}
