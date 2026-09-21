package com.Task.Tracker.Controller;

import com.Task.Tracker.Model.RegisterRequest;
import com.Task.Tracker.Model.User;
import com.Task.Tracker.Repo.UserRepo;
import com.Task.Tracker.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@RequestMapping("/tracker")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepo userRepo;

    @GetMapping("/home")
    public String home()
    {
        return "home";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

   @PostMapping("register")
    public String register(RegisterRequest registerRequest)
   {
        userService.registerUser(registerRequest);
        return "redirect:/tracker/verify-user";
   }
   @GetMapping("verify-user")
    public String verifyUser() {
        return "verify-user";
    }

    @GetMapping("confirm")
    @Transactional
    public String confirmUser(@RequestParam("token") String token) {

        Optional<User> userOptional = userRepo.findByVerificationToken(token);
        if (userOptional.isPresent()) {
            User user = userOptional.get();

            LocalDateTime tokenTime = user.getTokenCreationTime();
            if(tokenTime.plusMinutes(30).isBefore(LocalDateTime.now())) {

                userRepo.delete(user);
                return "redirect:/tracker/login?error=token-expired";
            }
            user.setEnabled(true);
            user.setVerificationToken(null);

            userRepo.save(user);
            System.out.println("User saved...");
            System.out.println("User :"+ user.getEmail() + " " + user.getUsername() + " "+ user.getPassword());

            return "redirect:/tracker/login?verified=true";
        }
        return "redirect:/tracker/login?error=invalid-token";
    }
}
