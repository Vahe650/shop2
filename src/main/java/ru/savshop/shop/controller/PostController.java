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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.savshop.shop.model.*;
import ru.savshop.shop.repository.*;
import ru.savshop.shop.security.CurrentUser;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.*;
import java.util.List;

@Controller
public class PostController {

    @Autowired
    private PostRepository postRepository;
    @Autowired
    private CountryRepository countryRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private PictureRepository pictureRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AttribValueRepository attribValueRepository;
    @Autowired
    private AttributeRepository attributeRepository;
    @Value("${shop.postpic.upload.path}")
    private String postImageUploadPath;

    @RequestMapping(value = "/post", method = RequestMethod.GET)
    public String adminPage(ModelMap map,
                            @ModelAttribute(name = "post") Post post,
                            @RequestParam(name = "categ",required = false) Integer id,@RequestParam(name = "message",required = false) String message, @AuthenticationPrincipal UserDetails userDetails) {

        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            map.addAttribute("current", user);
        }
        Category one = categoryRepository.findOne(id);
        if (one == null) {
            return "redirect:/nullErrors";
        }
        post.setCategory(one);
        map.addAttribute("message", message != null ? message : "");
        map.addAttribute("allcountry", countryRepository.findAll());
        map.addAttribute("postCategory", categoryRepository.findCategoryById(post.getCategory().getId()));
        map.addAttribute("post", new Post());
        map.addAttribute("atribValue", new AttributeValue());
        map.addAttribute("atribute", attributeRepository.findAllByCategory(post.getCategory()));
        return "post";
    }

    @RequestMapping(value = "/chooseCategory", method = RequestMethod.GET)
    public String changeCategory(ModelMap map, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            map.addAttribute("current", user);
        }
        map.addAttribute("allcategory", categoryRepository.findAll());
        map.addAttribute("mess", "Please choose category");
        map.addAttribute("post", new Post());
        return "chooseCategory";
    }

    @RequestMapping(value = "/addPost", method = RequestMethod.POST)
    public String AddPost(@Valid @ModelAttribute(name = "post") Post post,BindingResult result,
                          @RequestParam(value = "picture") MultipartFile[] uploadingFiles, @AuthenticationPrincipal UserDetails userDetails) throws IOException {
        StringBuilder sb = new StringBuilder();
        if (result.hasErrors()) {
            for (ObjectError objectError : result.getAllErrors()) {
                sb.append(objectError.getDefaultMessage()).append("<br>");
            }
            return "redirect:/post?categ="+post.getCategory().getId()+"&message=" + sb.toString();
        }
        if (post.getCategory() == null) {
            return "redirect:/chooseCategory";
        }
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            post.setUser(userRepository.getOne(currentUser.getId()));
        }
        post.setView(0);
        postRepository.save(post);
        for (AttributeValue attributeValue : post.getAttributeValues()) {
            attributeValue.setPost(post);
            attribValueRepository.save(attributeValue);
        }
        for (MultipartFile uploadedFile : uploadingFiles) {
            String path = System.currentTimeMillis() + "_" + uploadedFile.getOriginalFilename();
            File file = new File(postImageUploadPath + path);
            uploadedFile.transferTo(file);
            Picture picture = new Picture();
            picture.setPost(post);
            picture.setPicUrl(path);
            pictureRepository.save(picture);
        }
        return "redirect:/viewDetail?id=" + post.getId();
    }

    @RequestMapping(value = "/updatePost", method = RequestMethod.GET)
    public String updatePost(ModelMap map, @ModelAttribute(name = "post") Post post,
                             @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User user = ((CurrentUser) userDetails).getUser();
            map.addAttribute("current", user);
        }
        Post post1 = postRepository.findOne(post.getId());
        List<AttributeValue> allByPost = attribValueRepository.findAllByPost(post1);
        map.addAttribute("cur", post1);
        map.addAttribute("allcountry", countryRepository.findAll());
        map.addAttribute("postCategory", categoryRepository.findCategoryById(post1.getCategory().getId()));
        map.addAttribute("all", allByPost);
        map.addAttribute("atribute", attributeRepository.findAllByCategory(post1.getCategory()));
        map.addAttribute("atValue", attribValueRepository.findAllByPost(post1));
        return "editPost";
    }

    @RequestMapping(value = "/updateUserPost", method = RequestMethod.POST)
    public String AddPost(@ModelAttribute(name = "post") Post post, @RequestParam(name = "value", required = false) List<Attributes> value,
                          @RequestParam(value = "picture") MultipartFile[] uploadingFiles

    ) throws IOException {
        CurrentUser curretUser = (CurrentUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        post.setUser(userRepository.getOne(curretUser.getId()));
        post.setAtributes(value);
        postRepository.save(post);
        List<AttributeValue> attributeValues = post.getAttributeValues();
        for (int i = 0; i < value.size(); i++) {
            attributeValues.get(i).setAtributes(value.get(i));
            attributeValues.get(i).setPost(post);
        }
        attribValueRepository.save(attributeValues);
        if (uploadingFiles.length <= 1) {
            return "redirect:/viewDetail?id=" + post.getId();
        }
        for (MultipartFile uploadedFile : uploadingFiles) {
            String path = System.currentTimeMillis() + "_" + uploadedFile.getOriginalFilename();
            File file = new File(postImageUploadPath + path);
            uploadedFile.transferTo(file);
            Picture picture = new Picture();
            picture.setPicUrl(path);
            picture.setPost(post);
            pictureRepository.save(picture);
        }
        return "redirect:/viewDetail?id=" + post.getId();
    }

    @RequestMapping(value = "/picDelete")
    public String deletImage(@RequestParam("id") int id, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            User currentUser = ((CurrentUser) userDetails).getUser();
            Picture one = pictureRepository.getOne(id);
            if (one.getPost().getUser().getId() == currentUser.getId()) {
                pictureRepository.delete(one.getId());
            } else {
                return "redirect:/accessError";
            }
            return "redirect:/viewDetail?id=" + one.getPost().getId();
        }
        return "redirect:/login";
    }
        @RequestMapping(value = "/post/image", method = RequestMethod.GET)
        public void getImageAsByteArray (HttpServletResponse response, @RequestParam("fileName") String fileName) throws IOException {
            InputStream in = new FileInputStream(postImageUploadPath + fileName);
            response.setContentType(MediaType.IMAGE_JPEG_VALUE);
            response.setBufferSize(5000000);
            IOUtils.copy(in, response.getOutputStream());
        }
    }
