package com.Task.Tracker.Service;

import com.Task.Tracker.Model.RegisterRequest;
import com.Task.Tracker.Model.User;
import com.Task.Tracker.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    public void registerUser(RegisterRequest registerRequest)
    {
        User user = new User();
        user.setEmail(registerRequest.getEmail());
        user.setUsername(registerRequest.getUsername());
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));

        long userCount = userRepo.count();

        if(userCount == 0)
        {
            user.setRoles(Arrays.asList("ROLE_USER",  "ROLE_ADMIN"));
        }
        else
        {
            user.setRoles(Arrays.asList("ROLE_USER"));
        }

        String token = UUID.randomUUID().toString();
        user.setVerificationToken(token);
        user.setTokenCreationTime(LocalDateTime.now());
        user.setEnabled(false);
        userRepo.save(user);

        System.out.println("=================================");
        System.out.println("USER SAVED");
        System.out.println("ID       : " + user.getId());
        System.out.println("Username : " + user.getUsername());
        System.out.println("Email    : " + user.getEmail());
        System.out.println("Enabled  : " + user.isEnabled());
        System.out.println("Token    : " + user.getVerificationToken());
        System.out.println("Roles    : " + user.getRoles());
        System.out.println("=================================");

        emailService.sendVerficationToken(registerRequest.getEmail(), token);
    }
}
