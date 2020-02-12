package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	@RequestMapping("/index")
    public String hello(){
        return "home";
    }

    @RequestMapping("/changepwdpage")
    public String changepwdjsp(){
        return "changepwd";
    }

    @RequestMapping("/info")
    public String infojsp(){
        return "info";
    }

    @RequestMapping("/main")
    public String mainjsp(){
        return "main";
    }

    @RequestMapping("/notice")
    public String noticejsp(){
        return "notice";
    }


    @RequestMapping("/register")
    public String registerjsp(){
        return "register";
    }

    @RequestMapping("/search_result")
    public String search_resultjsp(){
        return "search_result";
    }

    @RequestMapping("/table")
    public String tablejsp(){
        return "table";
    }


    @RequestMapping("/trash")
    public String trashjsp(){
        return "trash";
    }
}
