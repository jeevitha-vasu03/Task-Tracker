    package com.Task.Tracker.Config;

    import com.Task.Tracker.Security.CustomUserDetailsService;
    import org.springframework.context.annotation.Bean;
    import org.springframework.context.annotation.Configuration;
    import org.springframework.security.config.annotation.web.builders.HttpSecurity;
    import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
    import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
    import org.springframework.security.crypto.password.PasswordEncoder;
    import org.springframework.security.web.SecurityFilterChain;
    import org.springframework.web.bind.annotation.ExceptionHandler;

    @Configuration
    @EnableWebSecurity
    public class SecurityConfig {

        private CustomUserDetailsService customUserDetailsService;

        public SecurityConfig(CustomUserDetailsService customUserDetailsService) {
            this.customUserDetailsService = customUserDetailsService;
        }

        @Bean
        public PasswordEncoder passwordEncoder() {
            return new BCryptPasswordEncoder();
        }

        @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
            http.csrf(csrf -> csrf.disable())
                    .authorizeHttpRequests(auth -> auth.requestMatchers("/Views/**", "/css/**",
                            "/images/**", "/static/**", "/tracker/login", "/tracker/register", "/tracker/verify-user", "/tracker/confirm").permitAll().anyRequest().authenticated())
                    .formLogin(form ->
                            form.loginPage("/tracker/login").defaultSuccessUrl("/tracker/home", true).loginProcessingUrl("/tracker/login").failureUrl("/tracker/login?error").permitAll())
                    .logout(logout -> logout.logoutSuccessUrl("/tracker/login").invalidateHttpSession(true))
                    .sessionManagement(sessionManagement -> sessionManagement.maximumSessions(1));
            return http.build();
        }
    }
