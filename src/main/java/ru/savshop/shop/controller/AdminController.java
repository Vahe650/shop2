package ru.savshop.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import ru.savshop.shop.mail.EmailServiceImp;
import ru.savshop.shop.model.*;
import ru.savshop.shop.repository.*;
import ru.savshop.shop.security.CurrentUser;

import javax.validation.Valid;
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
    public String adminPage(ModelMap map, @RequestParam(name = "message",
            required = false) String message) {
//        List<Category> categories = new LinkedList<>();
//        for (Category category : categoryRepository.findAll()) {
//            if (category.getParentId() == 0) {
//                categories.add(category);
//            }
//            for (Category category1 : categoryRepository.findAll()) {
//                    if (category.getId() == category1.getParentId()) {
//                        categories.add(category1);
//                    }
//                }
//            }
        map.addAttribute("allCategories", categoryRepository.findAll());
        map.addAttribute("message", message != null ? message : "");
        map.addAttribute("category", new Category());
        map.addAttribute("categories", new Category());
        map.addAttribute("country", new Country());
        map.addAttribute("allCountries", countryRepository.findAll());
        map.addAttribute("atribute", new Attributes());
        map.addAttribute("allAtributes", attributeRepository.findAll());
        map.addAttribute("allUsers", userRepository.findAll());
        return "adminPage";
    }

    @RequestMapping(value = "/admin/addCategory", method = RequestMethod.POST)
    public String adminPageAddCategory(@Valid @ModelAttribute(name = "category") Category category, BindingResult result) {
        StringBuilder sb = new StringBuilder();
        if (result.hasErrors()) {
            for (ObjectError objectError : result.getAllErrors()) {
                sb.append(objectError.getDefaultMessage()).append("<br>");
            }
            return "redirect:/admin?message=" + sb.toString();
        }
        categoryRepository.save(category);
        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/addParrentCategoryAndAtribute", method = RequestMethod.POST)
    public String addParrentCategoryAndAtribute(@Valid @ModelAttribute(name = "category") Category categories, BindingResult result,
                                                @RequestParam("atributes") List<String> atributes) {
        StringBuilder sb = new StringBuilder();
        if (result.hasErrors()) {
            for (ObjectError objectError : result.getAllErrors()) {
                sb.append(objectError.getDefaultMessage()).append("<br>");
            }
            return "redirect:/admin?message=" + sb.toString();
        }
        categoryRepository.save(categories);
        for (String attribute : atributes) {
            Attributes categoryAttribute = new Attributes();
            categoryAttribute.setCategory(categories);
            categoryAttribute.setAttributeName(attribute);
            attributeRepository.save(categoryAttribute);
        }
        return "redirect:/admin";
    }

    @RequestMapping(value = "/admin/addCountry", method = RequestMethod.POST)
    public String adminPageAddcountry(@Valid @ModelAttribute(name = "country") Country country, BindingResult result) {
        StringBuilder sb = new StringBuilder();
        if (result.hasErrors()) {
            for (ObjectError objectError : result.getAllErrors()) {
                sb.append(objectError.getDefaultMessage()).append("<br>");
            }
            return "redirect:/admin?message=" + sb.toString();
        }
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
        final Optional<User> byId = userRepository.findById(id);
        byId.ifPresent(userRepository::delete);
        return "redirect:/admin/searchUser";
    }

    @RequestMapping(value = "/admin/deletePost")
    public String del(@RequestParam("id") int id) {
        final Optional<Post> byId = postRepository.findById(id);
        byId.ifPresent(postRepository::delete);
        return "redirect:/admin/allUsers";
    }

    @RequestMapping(value = "/admin/searchUser", method = RequestMethod.GET)
    public String searchUser(ModelMap modelMap, @RequestParam(name = "search", required = false) String search, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            final Optional<User> byId = userRepository.findById(currentUser.getId());
            byId.ifPresent(user ->modelMap.addAttribute("current", user) );
        }
        modelMap.addAttribute("allPosts", postRepository.findByUserVerify());
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

    @RequestMapping(value = "/admin/blockUser")
    public String update(@RequestParam("id") int id) {
        User user = userRepository.findById(id).get();
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
            String url = String.format("http://localhost:8080/admin/unblockVerify?token=%s&email=%s", user.getToken(), user.getEmail());
            String text = String.format("hello %s you are unblocked, click " +
                    "on this link for visiting your profile %s", user.getName(), url);
            emailServiceImp.sendSimpleMessage(user.getEmail(), "Welcome...", text);
        }
        return "redirect:/admin/searchUser?search=" + user.getEmail();
    }

    @RequestMapping(value = "/admin/unblockVerify", method = RequestMethod.GET)
    public String unblock(@RequestParam("token") String token, @RequestParam("email") String email) {
        User one = userRepository.findOneByEmail(email);
        if (one != null) {
            if (one.getToken() != null && one.getToken().equals(token)) {
                one.setToken(" ");
                one.setVerify(true);
                userRepository.save(one);
            }
        }
        return "redirect:/";
    }
}
