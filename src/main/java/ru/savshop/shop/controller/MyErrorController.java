package ru.savshop.shop.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyErrorController implements ErrorController {
    @Override
    public String getErrorPath() {
        return "/error";
    }

    @RequestMapping("/error")
    public String error(){
        return "404";
    }
        @RequestMapping(value = "/verifyError")
    public String verifyerror(ModelMap map) {
        map.addAttribute("errorMessage", "You're not verified your account. \n Check your Email!!!");
        return "login";
    }

    @RequestMapping(value = "/inccorectError")
    public String incorrectError(ModelMap map) {
        map.addAttribute("errorMessage", "Login or password are entered incorrectly!\nTry again");
        return "login";
    }

    @RequestMapping(value = "/accessError")
    public String accesstError(ModelMap map) {
        map.addAttribute("errorMessage", "Sorry, you do not have permission to view this page.");
        return "login";

    }
}
