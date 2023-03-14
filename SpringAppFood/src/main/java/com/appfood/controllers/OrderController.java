package com.appfood.controllers;

import com.appfood.pojo.*;
import com.appfood.service.*;
import com.appfood.utils.Utils;
import com.appfood.validator.ProductValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@ControllerAdvice
public class OrderController {
    @Autowired
    UserService userService;

    @Autowired
    OrderService orderService;

    @Autowired
    RestaurantService restaurantService;

    private void loadAllList(Model model) {
        List<User> users = userService.getByRole(User.NHAHANG, 0, 1);
        model.addAttribute("users", users);
    }

    @RequestMapping(value = "/restaurant/order")
    public String index(Model model,
                        @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        int id = Integer.parseInt(params.getOrDefault("id", "0"));
        String amount = params.getOrDefault("amount", null);
        String active = params.getOrDefault("active", null);

        Map<String, String> pre = new HashMap<>();
        if (id != 0) {
            pre.put("id", "id");
            model.addAttribute("id", id);
        }
        if (amount != null) {
            pre.put("amount", amount);
            model.addAttribute("amount", amount);
        }

        if (active != null) {
            pre.put("active", active);
            model.addAttribute("active", active);
        }


        List<SaleOrder> orders = orderService.getOrders(pre, page);
       List<SaleOrder> ordersSize = orderService.getOrders(pre, 0);
       model.addAttribute("orders", orders);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", ordersSize.size());
        model.addAttribute("productService", orderService);

        // another
        model.addAttribute("userService", userService);
        model.addAttribute("restaurantService", restaurantService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "restaurant-order";
    }

    @GetMapping("/restaurant/order/view")
    public String viewOrder(Model model,
                              Authentication authentication,
                              @RequestParam(name = "id", defaultValue = "0") int id) {

        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0)
            return "access-denied";

        int userId = this.userService.getUserByUsername(authentication.getName()).getId();

        if (id > 0) {
            SaleOrder order = this.orderService.getOrderById(id);
            if (order != null && order.getUserId().getId() == userId) {
                model.addAttribute("order", order);


            } else {
                return "redirect:/access-denied";
            }
        } else {
            return "restaurant-order";
        }

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "restaurant-view-order";
    }
    @GetMapping(path = "/restaurant/order/delete")
    public String deleteOrderById(Model model,
                                    Authentication authentication,
                                    @RequestParam(name = "id", defaultValue = "0") int id,
                                    final RedirectAttributes redirectAttrs) {
        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0)
            return "access-denided";

        int userId = this.userService.getUserByUsername(authentication.getName()).getId();

        String errMsg = null;
        String sucMsg = null;
        SaleOrder order = new SaleOrder();

        if (id > 0) {
            order = this.orderService.getOrderById(id);
            if (!(order != null && order.getUserId().getId() == userId)) {
                return "redirect:/access-denied";
            }
        }

        boolean deleteCheck = orderService.delete(order);


        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/restaurant/order";
    }

}
