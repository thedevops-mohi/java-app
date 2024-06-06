package com.example.helloworld;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
public class HelloWorldController {

    @GetMapping("/")
    public String helloWorld() {
        String hostAddress = getHostAddress();
        return "<html><body style='color:blue;'><h1>Hello, World!</h1><p>Your host IP address is: " + hostAddress + "</p></body></html>";
    }

    private String getHostAddress() {
        try {
            return InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            e.printStackTrace();
            return "Unknown Host";
        }
    }
}
