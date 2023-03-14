/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.controllers;

import com.appfood.pojo.User;
import com.appfood.service.UserService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author thien thien
 */
@Controller
@Transactional
public class AccountPermissionController {

    @Autowired
    private UserService userService;

    @RequestMapping("/admin/account-permission")
    public String index(Model model,
        @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));

        List<User> users = userService.getByRole(User.NHAHANG, page, 0);
        List<User> usersSize = userService.getByRole(User.NHAHANG,0,0);
        model.addAttribute("users", users);
//
        model.addAttribute("currentPage", page);

        model.addAttribute("counter", usersSize.size());
        model.addAttribute("userService", userService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));
       

        return "account-permission";
    }

    @RequestMapping(path = "/admin/account-permission/accept")
    public String acceptAccount(Model model,
            @RequestParam(name = "id", defaultValue = "0") int id,
            final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        User user = new User();
        if (id != 0) {
            user = this.userService.getUserById(id);
            user.setActive(1);
        }

        if (user.getActive() == 1) {
            sucMsg = String.format("Xác nhận nhà hàng '%s' thành công", user.getUsername());
        } else {
            errMsg = String.format("Xác nhận nhà hàng '%s' không thành công", user.getUsername());
        }
        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account-permission";
    }

    @RequestMapping(path = "/admin/account-permission/accept-all")
    public String acceptAllAccount(Model model,
            final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        List<User> users = userService.getByRole(User.NHAHANG,0, 0);
        users.forEach(user -> user.setActive(1));

        int numberCheck = userService.getByRole(User.NHAHANG,0, 0).size();
        if (numberCheck == 0) {
            sucMsg = "Đã xác nhận tất cả nhà hàng thành công";
        } else {
            errMsg = "Có lỗi khi xác nhận tất cả nhà hàng";
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/account-permission";
    }
}
