package ru.savshop.shop.controller;

import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.boot.context.config.ResourceNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import ru.savshop.shop.handler.NotFound;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;

@Controller
public class ExceptionController implements ErrorController {
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

    //
//    @RequestMapping(value = {"/{name:.+}", "/{name}/{name}"}, method = RequestMethod.GET)
//    public String viewEdit(@PathVariable("name") final String name, ModelMap model) {
//        if (name.equals("null"))
//            throw new NotFound();
//        model.addAttribute("msg", "Page not found");
//        return "404";
//    }
    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String renderErrorPage(ModelMap map, HttpServletRequest httpRequest) throws Exception {
        String errorMsg = "";
        int httpErrorCode = getErrorCode(httpRequest);
        switch (httpErrorCode) {
            case 400: {
                errorMsg = "Http Error Code: " + httpErrorCode + ". Bad Request";
                break;
            }
            case 401: {
                errorMsg = "Http Error Code:  " + httpErrorCode + ". Unauthorized";
                break;
            }
            case 404: {
                errorMsg = "Http Error Code:" + httpErrorCode + ". Resource not found";
                break;
            }
            case 500: {
                errorMsg = "Http Error Code: " + httpErrorCode + ". Internal Server Error";
                break;
            }
        }
        map.addAttribute("msg", errorMsg);


        return "404";
    }



    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
                .getAttribute("javax.servlet.error.status_code");
    }


    @RequestMapping("/nullErrors")
    public String handleError(ModelMap map) {
        map.addAttribute("msg","you are in wrong way ");
        return "404";
    }

    @Override
    public String getErrorPath() {
        return "redirect:/error";
    }
}

