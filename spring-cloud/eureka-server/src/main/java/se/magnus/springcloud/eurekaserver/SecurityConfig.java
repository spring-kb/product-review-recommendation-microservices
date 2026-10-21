package se.magnus.springcloud.eurekaserver;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    private final String username;
    private final String password;
    
    // The username and password are injected into the constructor from the configuration file
    public SecurityConfig(
            @Value("${app.eureka-username}") String username,
            @Value("${app.eureka-password}") String password) {
        this.username = username;
        this.password = password;
    }

    @Bean
    public InMemoryUserDetailsManager userDetailsService() {
        @SuppressWarnings("deprecation") // Ok for test purposes, not for production use
        UserDetails user = User.withDefaultPasswordEncoder()
                .username(username)
                .password(password)
                .roles("USER")
                .build();
        return new InMemoryUserDetailsManager(user);
    }

    @Bean
    public SecurityFilterChain configure(HttpSecurity http) throws Exception {
        // All APIs and web pages are protected using HTTP Basic authentication
        // Disable CSRF to allow services to register themselves with Eureka
        http.csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(requests -> requests.anyRequest().authenticated())
            .httpBasic(Customizer.withDefaults());
        
            return http.build();
    }
}