package com.absensi_api.dto;

public class LoginResponse {

    private Boolean status;
    private String message;
    private String role;
    private String username;

    public LoginResponse(Boolean status, String message, String role, String username) {
        this.status = status;
        this.message = message;
        this.role = role;
        this.username = username;
    }

    public Boolean getStatus() {
        return status;
    } 

    public String getMessage() {
        return message;
    }

    public String getRole() {
        return role;
    }

    public String getUsername() {
        return username;
    }
}