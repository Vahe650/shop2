package ru.savshop.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import ru.savshop.shop.model.Category;
import ru.savshop.shop.model.Post;
import ru.savshop.shop.model.User;
import ru.savshop.shop.repository.*;
import ru.savshop.shop.security.CurrentUser;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;


@Controller
public class MainController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private AttribValueRepository attribValueRepository;



    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String mainPage(ModelMap modelMap, @AuthenticationPrincipal UserDetails userDetails) {
        modelMap.addAttribute("allPosts",postRepository.findByUserVerify());
        modelMap.addAttribute("four", postRepository.lastFour());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        modelMap.addAttribute("userDetail", userRepository.findAll());
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findOne(user.getId()));
        }
        return "indax";
    }


    @RequestMapping(value = "/searchResult", method = RequestMethod.GET)
    public String result(ModelMap modelMap, @RequestParam(name = "search", required = false) String search,@AuthenticationPrincipal UserDetails userDetails){
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findOne(currentUser.getId()));
        }
        modelMap.addAttribute("allPosts",postRepository.findByUserVerify());
        modelMap.addAttribute("four", postRepository.lastFour());
        modelMap.addAttribute("check", postRepository.lastFour());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        List<Post> postList = postRepository.findPostsByTitleLike(search.trim());
        if ( postList.isEmpty()) {
            modelMap.addAttribute("mes", "Search Result with " + "' " + search + " '" + " not Found");
        } else {
            modelMap.addAttribute("result", postList);
        }
        return "result";
    }

    @RequestMapping(value = "/categorySearch", method = RequestMethod.GET)
    public String catergoryResult(ModelMap modelMap, @RequestParam(name = "id") int id,@RequestParam(name = "mes",
            required = false) String mes, @AuthenticationPrincipal UserDetails userDetails) {
        Category one = categoryRepository.findOne(id);
        if (one==null){
            return "redirect:/nullErrors";
        }
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findOne(currentUser.getId()));
        }
        modelMap.addAttribute("mes", mes != null ? mes: "");
        List<Post> postList = postRepository.findPostsByCategoryIdOrderByViewDesc(id);
        if (postList.isEmpty()){
            modelMap.addAttribute("mes","there is no any post in '"+one.getName()+"' CATEGORY");
            modelMap.addAttribute("check", postRepository.lastFour());

        }
        modelMap.addAttribute("four",postRepository.lastFour());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        modelMap.addAttribute("allPosts",postRepository.findByUserVerify());
        modelMap.addAttribute("result", postList);
        return "result";
    }
    @RequestMapping(value = "/middleRange")
    public String middle(ModelMap map, @RequestParam(name = "firstInt") int firstId,
                         @RequestParam(name = "secondInt") int secondId,
                         @RequestParam(name = "id") int id,@AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            map.addAttribute("current", userRepository.findOne(currentUser.getId()));
        }
        if (id!=categoryRepository.findOne(id).getId()){
            return "redirect:/nullErrors";
        }
        map.addAttribute("allPosts", postRepository.findByUserVerify());
        map.addAttribute("four", postRepository.lastFour());
        map.addAttribute("allCategories", categoryRepository.findAll());
        List<Post> postList = postRepository.betweenPrice(firstId, secondId,id);
        if (postList.isEmpty()) {
            String mes="There is no any posts in  " + firstId + " from " + secondId + " range";
            map.addAttribute("mes", mes);
            return"redirect:/categorySearch?id="+id+"&mes="+mes;
        } else {
            map.addAttribute("result", postList);
            map.addAttribute("mes", "this is all posts from "+firstId+" to "+secondId);
        }
        return "result";
    }

    @RequestMapping(value = "/viewDetail", method = RequestMethod.GET)
    public String viewDetail(ModelMap map, @RequestParam(name = "id", required = false) int id,
                             @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            map.addAttribute("current", currentUser);
        }
        Post post = postRepository.findOne(id);
        if (post==null){
            return "redirect:/nullErrors";
        }
        int view = post.getView();
        post.setView(++view);
        postRepository.save(post);
        post.setAttributeValues(attribValueRepository.findAllByPost(post));
        map.addAttribute("curentPost", post);
        map.addAttribute("allPosts",postRepository.findByUserVerify());
        map.addAttribute("four", postRepository.lastFour());
        map.addAttribute("allCategories", categoryRepository.findAll());
        return "detail";
    }

    @RequestMapping(value = "/contactUs", method = RequestMethod.GET)
    public String contact(ModelMap modelMap, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findOne(currentUser.getId()));
        }
        modelMap.addAttribute("allPosts", postRepository.findByUserVerify());
        modelMap.addAttribute("four", postRepository.lastFour());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        return "contact";
    }

    @RequestMapping(value = "/userHelp", method = RequestMethod.GET)
    public String help(ModelMap modelMap, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findOne(currentUser.getId()));
        }
        modelMap.addAttribute("allPosts", postRepository.findByUserVerify());
        modelMap.addAttribute("four", postRepository.lastFour());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        return "help";
    }


    @RequestMapping(value = "/userConditions", method = RequestMethod.GET)
    public String conditions(ModelMap modelMap, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            modelMap.addAttribute("current", userRepository.findOne(currentUser.getId()));
        }
        modelMap.addAttribute("allPosts", postRepository.findByUserVerify());
        modelMap.addAttribute("four", postRepository.lastFour());
        modelMap.addAttribute("allCategories", categoryRepository.findAll());
        return "conditions";
    }
}
