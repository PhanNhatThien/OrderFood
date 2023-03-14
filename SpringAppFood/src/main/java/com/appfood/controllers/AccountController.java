package com.appfood.controllers;

import com.appfood.pojo.Product;
import com.appfood.pojo.Restaurant;
import com.appfood.pojo.User;
import com.appfood.service.RestaurantService;
import com.appfood.service.UserService;
import com.appfood.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.persistence.NoResultException;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class AccountController {

    @Autowired
    private UserService userService;
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private UserValidator userValidator;

    @RequestMapping("/admin/account")
    public String index(Model model,
                        @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String username = params.getOrDefault("username", null);
        String phone = params.getOrDefault("phone", null);
        String email = params.getOrDefault("email", null);
        String userRole = params.getOrDefault("userRole", null);

        Map<String, String> pre = new HashMap<>();
        if (username != null) {
            pre.put("username", username);
            model.addAttribute("usernameSearch", username);
        }
        if (phone != null) {
            pre.put("phone", phone);
            model.addAttribute("phoneSearch", phone);
        }
        if (email != null) {
            pre.put("email", email);
            model.addAttribute("emailSearch", email);
        }
        if (userRole != null) {
            pre.put("userRole", userRole);
            model.addAttribute("userRoleSearch", userRole);
        }

        List<User> users = userService.getUsersMultiCondition(pre, page);
        List<User> usersSize = userService.getUsersMultiCondition(pre, 0);
        model.addAttribute("users", users);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", usersSize.size());
        model.addAttribute("userService", userService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "admin-account";
    }

    // XEM CHI TIET TAI KHOAN
    @GetMapping("/admin/account/view")
    public String viewAccount(Model model,
                              @RequestParam(name = "id", defaultValue = "0") int id) {
        User user = this.userService.getUserById(id);

        if (user != null) {
            model.addAttribute("user", user);
            try {
                user = userService.getUserById(id);
            } catch (NoResultException nre) {
                System.err.println(nre.getMessage());
            }

        } else
            return "redirect:/admin/account";

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "view-account";
    }
//
//    // THEM HOAC CAP NHAT TAI KHOAN
    @GetMapping("/admin/account/add-or-update")
    public String addOrUpdateAccountView(Model model,
                                         @RequestParam(name = "id", defaultValue = "0") int id) {
        if (id > 0)
            model.addAttribute("user", this.userService.getUserById(id));
        else {
            User user = new User();
            user.setId(0);
            model.addAttribute("user", user);
        }

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "add-account";
    }
//
    @PostMapping("/admin/account/add-or-update")
    public String addOrUpdateAccount(Model model,
                                     @ModelAttribute(value = "user") @Valid User user,
                                     BindingResult result,
                                     final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;


        if (result.hasErrors())
            return "add-account";


        boolean addOrUpdateCheck = this.userService.addOrUpdate(user);
        if (addOrUpdateCheck) {
            if (user.getUserRole().equals(User.USER)) {
                redirectAttrs.addFlashAttribute("userId",
                        userService.getUserByUsername(user.getUsername()).getId());
                return "redirect:/admin/account/add-or-update";
            }
            redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
            return "redirect:/admin/account";
        } else {
            errMsg = "Thêm thông tin tài khoản không thành công";
        }
        model.addAttribute("errMsg", errMsg);
        return "add-account";
    }

    @RequestMapping(path = "/admin/account/delete")
    @Transactional
    public String deleteAccountById(Model model,
                                    @RequestParam(name = "id", defaultValue = "0") int id,
                                    final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;
        User user = new User();

        if (id > 0) {
            user = this.userService.getUserById(id);

            boolean deleteCheck = userService.delete(user);
            if (user != null && deleteCheck) {
                sucMsg = String.format("Xoá thành công user '%s'", user.getUsername());
            } else {
                assert user != null;
                errMsg = String.format("Xoá không thành công user '%s'", user.getUsername());
            }
        } else {
            errMsg = String.format("Xoá không thành công user '%s'", user.getUsername());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account";
    }

    @RequestMapping("/info-account/view")
    public String infoAccountView(Model model, Authentication authentication) {

        try {

            int userId = this.userService.getUserByUsername(authentication.getName()).getId();
            model.addAttribute("userId", userId);
        } catch (NoResultException nre){
            System.out.println(nre.getMessage());
        }

        Restaurant restaurant;

        try {
            restaurant = restaurantService.getByUserId(userService.getUserByUsername(authentication.getName()).getId());
            model.addAttribute("restaurant", restaurant);
        } catch (NoResultException nre){
            System.out.println(nre.getMessage());
        }

        return "info-account-view";
    }

}
