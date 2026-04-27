package com.absensi_api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.absensi_api.model.User;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsernameAndPassword(String username, String password);

    User findByEmail(String email);

    Optional<User> findByUsername(String username);
}
