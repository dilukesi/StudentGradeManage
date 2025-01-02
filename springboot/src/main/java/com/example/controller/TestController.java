package com.example.controller;
 
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
@RequestMapping(value="/api")
public class TestController{
    @GetMapping("/test")
    public Object myTest() throws Exception {
 
        return "hello world!";
    }
}