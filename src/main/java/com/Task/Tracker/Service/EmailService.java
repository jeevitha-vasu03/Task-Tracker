package com.Task.Tracker.Service;

import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendVerficationToken(String email, String token) {
        try
        {
            String verificationURL = "http://localhost:8081/tracker/confirm?token="+token;

            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom("jeevithavasu0308@gmail.com");
            helper.setTo(email);
            helper.setSubject("Registration Confirmation");
            helper.setText("Please verify your account by clicking :"+ verificationURL);
            String htmlContent =
                    "<div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #eee;'>" +
                            "<h2>Welcome!</h2>" +
                            "<p>Click the button below to verify your email:</p>" +

                            // The Main Button
                            "<div style='margin: 25px 0;'>" +
                            "<a href='" + verificationURL + "' " +
                            "style='background-color: #004a7c; color: white; padding: 12px 20px; " +
                            "text-decoration: none; border-radius: 5px; font-weight: bold; display: inline-block;'>" +
                            "Verify My Account</a>" +
                            "</div>" +

                            // The Backup Link
                            "<p style='font-size: 14px; color: #555;'>" +
                            "If the button above doesn't work, copy and paste this link into your browser:" +
                            "</p>" +
                            "<p style='font-size: 12px; color: #004a7c; word-break: break-all;'>" +
                            verificationURL +
                            "</p>" +

                            "<hr style='border:none; border-top:1px solid #eee; margin-top:30px;'>" +
                            "<p style='color: #888; font-size: 12px;'>This link will expire soon.</p>" +
                            "</div>";
            helper.setText(htmlContent, true);
            mailSender.send(mimeMessage);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}
