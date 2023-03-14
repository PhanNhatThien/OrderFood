/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.controllers;

import com.appfood.pojo.*;
import com.appfood.service.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.NoResultException;
import javax.validation.Valid;

import com.appfood.validator.ProductValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author thien thien
 */
@Controller
@Transactional
public class RestaurantController {

    @Autowired
    private UserService userService;

    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private ProductService productService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    ProductValidator productValidator;

    private void loadAllList(Model model) {
        List<Category> categories = categoryService.getCategories("",0);
        model.addAttribute("categories", categories);
        List<User> users = userService.getByRole(User.NHAHANG, 0, 1);
        model.addAttribute("users", users);
    }

    private void loadAllService(Model model) {
        model.addAttribute("categoryService", categoryService);
        model.addAttribute("restaurantService", restaurantService);
        model.addAttribute("userService", userService);
    }

    @RequestMapping("/restaurant")
    public String index() {
//        model.addAttribute("active", "1");
        return "restaurant";
    }

    @RequestMapping("/restaurant/management")
    public String management(Model model,
            Authentication authentication,
            @RequestParam(required = false) Map<String, String> params) {

        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }

        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String name = params.getOrDefault("name", null);
        String description = params.getOrDefault("description", null);


        Map<String, String> pre = new HashMap<>();
        if (name != null) {
            pre.put("name", name);
            model.addAttribute("name", name);
        }
        if (description != null) {
            pre.put("description", description);
            model.addAttribute("description", description);
        }
//


        int maxItems = 20;
        model.addAttribute("maxItems", maxItems);

        pre.put("postedByUserId", String.valueOf(this.userService.getUserByUsername(authentication.getName()).getId()));
        List<Product> products = productService.getProducts(pre, page);
        List<Product> productsSize = productService.getProducts(pre, 0);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", productsSize.size());
        model.addAttribute("productService", productService);

        loadAllService(model);
        model.addAttribute("products", products);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "restaurant-management";
    }

    @GetMapping("/restaurant/post/add-or-update")
    public String addOrUpdateRestaurant(Model model,
            Authentication authentication,
            @RequestParam(name = "id", defaultValue = "0") int id) {

        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }

        int userId = this.userService.getUserByUsername(authentication.getName()).getId();

//        Product product = new Product();
//        product.setId(0);
//        model.addAttribute("product", product);
        if (id > 0) {
            Product product = this.productService.getProductById(id);
            if (product != null && product.getPostedByUser().getId() == userId) {
                model.addAttribute("product", product);

            } else {
                return "redirect:/access-denied";
            }
        } else {
            Product product = new Product();
            product.setId(0);
            model.addAttribute("product", product);
        }

        loadAllList(model);

        return "restaurant-add-post";
    }

    @PostMapping(value = "/restaurant/post/add-or-update")
    public String addOrUpdateRestaurant(Model model,
            Authentication authentication,
            @ModelAttribute(value = "product") @Valid Product product,
            BindingResult result,
            final RedirectAttributes redirectAttrs) throws ParseException {

        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }

        String errMsg = null;
        String sucMsg = null;

        loadAllList(model);

        productValidator.validate(product, result);
        if (result.hasErrors()) {
            return "restaurant-add-post";
        }

        product.setPostedByUser(userService.getUserById(product.getPostedByUserId()));
        product.setCategoryId(categoryService.getById(product.getCategoryById()));
//        product.setCreatedDate(new Date());

//        if (!jobPost.getExpiredDateStr().equals(""))
//            jobPost.setExpiredDate(new SimpleDateFormat("yyyy-MM-dd").parse(jobPost.getExpiredDateStr()));
//
        boolean productAddedCheck = this.productService.addProduct(product);
        if (productAddedCheck) {

            sucMsg = String.format("Thêm thành công tin nhà hàng ");

        } else {
            errMsg = String.format("Thêm tin nhà hàng thất bại");
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "restaurant-add-post";
    }

    @GetMapping("/restaurant/post/view")
    public String viewProduct(Model model,
                              Authentication authentication,
                              @RequestParam(name = "id", defaultValue = "0") int id) {

        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0)
            return "access-denied";

        int userId = this.userService.getUserByUsername(authentication.getName()).getId();

        if (id > 0) {
            Product product = this.productService.getProductById(id);
            if (product != null && product.getPostedByUser().getId() == userId) {
                model.addAttribute("product", product);

                Category category = this.categoryService.getById(product.getCategoryId().getId());
                model.addAttribute("category", category);
            } else {
                return "redirect:/access-denied";
            }
        } else {
            return "restaurant-management";
        }

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "restaurant-view-post";
    }

    @GetMapping(path = "/restaurant/post/delete")
    public String deleteProductById(Model model,
                                    Authentication authentication,
                                    @RequestParam(name = "id", defaultValue = "0") int id,
                                    final RedirectAttributes redirectAttrs) {
        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0)
            return "access-denided";

        int userId = this.userService.getUserByUsername(authentication.getName()).getId();

        String errMsg = null;
        String sucMsg = null;
        Product product = new Product();

        if (id > 0) {
            product = this.productService.getProductById(id);
            if (!(product != null && product.getPostedByUser().getId() == userId)) {
                return "redirect:/access-denied";
            }
        }

        boolean deleteCheck = productService.delete(product);
        if (deleteCheck) {
            sucMsg = String.format("Xoá thành công bài viết nhà hàng '%s'", product.getName());
        } else {
            errMsg = String.format("Xoá không thành công bài viết nhà hàng '%s'", product.getName());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/restaurant/management";
    }


    @GetMapping("/restaurant/stats-cate")
    public String statsCategory(Model model) {
        model.addAttribute("catStat", this.productService.countProdsByCate());
        return "stats-cate";
    }


    @GetMapping("/restaurant/stats-revenue")
    public String statsRevenue(Model model,
                        @RequestParam(value = "quarter", required = false, defaultValue = "1") int quarter,

                        @RequestParam(value = "year", defaultValue = "2022") int year) {



        model.addAttribute("revenuStats", this.productService.revenueStats(quarter, year));
        return "stats-revenue";
    }

    @RequestMapping("/restaurant/confirm-order")
    public String confirmOrder(Model model,Authentication authentication,
            @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }

        List<SaleOrder> orders = orderService.getByActive(0);
        List<SaleOrder> ordersSize = orderService.getByActive(0);
        model.addAttribute("orders", orders);
//
//        model.addAttribute("currentPage", page);

        model.addAttribute("counter", ordersSize.size());
        model.addAttribute("orderService", orderService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "restaurant-confirm-order";
    }

    @RequestMapping(path = "/restaurant/confirm-order/accept")
    public String acceptOrder(Model model,Authentication authentication,
            @RequestParam(name = "id", defaultValue = "0") int id,
            final RedirectAttributes redirectAttrs) {
        
        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }
        
        String errMsg = null;
        String sucMsg = null;

        SaleOrder order = new SaleOrder();
        if (id != 0) {
            order = this.orderService.getOrderById(id);
            order.setActive(1);
        }

        if (order.getActive() == 1) {
            sucMsg = String.format("Xác nhận đơn hàng '%s' thành công", order.getUserId());
        } else {
            errMsg = String.format("Xác nhận đơn hàng '%s' không thành công", order.getUserId());
        }
        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/restaurant/confirm-order";
    }

    @RequestMapping("/restaurant/confirm-product")
    public String confirmProduct(Model model,Authentication authentication,
                               @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }

        List<Product> products = productService.getByActive(0);
        List<Product> productsSize = productService.getByActive(0);
        model.addAttribute("products", products);
//
//        model.addAttribute("currentPage", page);

        model.addAttribute("counter", productsSize.size());
        model.addAttribute("productService", productService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "restaurant-confirm-product";
    }
    @RequestMapping(path = "/restaurant/confirm-product/accept")
    public String acceptProduct(Model model,Authentication authentication,
                              @RequestParam(name = "id", defaultValue = "0") int id,
                              final RedirectAttributes redirectAttrs) {

        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }

        String errMsg = null;
        String sucMsg = null;

        Product product = new Product();
        if (id != 0) {
            product = this.productService.getProductById(id);
            product.setActive(true);
        }

        if (product.getActive() == true) {
            sucMsg = String.format("Thay đổi trạng thái '%s' thành công", product.getPostedByUser());
        } else {
            errMsg = String.format("Thay đổi trạng thái '%s' không thành công", product.getPostedByUser());
        }
        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/restaurant/confirm-product";
    }
    @RequestMapping(path = "/restaurant/confirm-product/cancel")
    public String cancelProduct(Model model,Authentication authentication,
                                @RequestParam(name = "id", defaultValue = "0") int id,
                                final RedirectAttributes redirectAttrs) {

        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0) {
            return "access-denied";
        }

        String errMsg = null;
        String sucMsg = null;

        Product product = new Product();
        if (id == 0) {
            product = this.productService.getProductById(id);
            product.setActive(false);
        }

        if (product.getActive() == false) {
            sucMsg = String.format("Thay đổi trạng thái '%s' thành công", product.getPostedByUser());
        } else {
            errMsg = String.format("Thay đổi trạng thái '%s' không thành công", product.getPostedByUser());
        }
        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/restaurant/confirm-product";
    }

    @GetMapping("/restaurant/restaurant-info/add-or-update")
    public String updateRestaurantView(Model model,
                                     Authentication authentication) {
        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0)
            return "restaurant";

        int userId = this.userService.getUserByUsername(authentication.getName()).getId();

        Restaurant restaurant;
        try {
            restaurant = restaurantService.getByUserId(userId);
        } catch (NoResultException nre) {
            restaurant = new Restaurant();
            restaurant.setId(0);
        }
        model.addAttribute("restaurant", restaurant);
        model.addAttribute("userId", userId);
        model.addAttribute("actionUrl", "/restaurant/restaurant-info/add-or-update");
        return "restaurant-add-info-account";
    }
    @PostMapping("/restaurant/restaurant-info/add-or-update")
    public String addOrUpdateRestaurant(Model model,
                                      Authentication authentication,
                                      @ModelAttribute(value = "restaurant") Restaurant restaurant) {
        if (this.userService.getUserByUsername(authentication.getName()).getActive() == 0)
            return "restaurant";

        String errMsg = null;
        String sucMsg = null;

        User restaurantUser = userService.getUserById(restaurant.getUserId());
        restaurant.setUser(restaurantUser);
        int checkMsg = restaurant.getId();
        if (this.restaurantService.addOrUpdate(restaurant)) {
            if (checkMsg == 0)
                sucMsg = String.format("Thêm thông tin user và thông tin nhà hàng '%s' thành công", restaurantUser.getUsername());
            else
                sucMsg = "Cập nhật thông tin user và thông tin nhà hàng thành công";
        } else {
            if (checkMsg == 0)
                errMsg = String.format("Thêm thông tin user và thông tin nhà hàng '%s' không thành công", restaurantUser.getUsername());
            else
                errMsg = "Cập nhật thông tin user và thông tin nhà hàng không thành công";

            model.addAttribute("errMsg", errMsg);
        }

        model.addAttribute("actionUrl", "/restaurant/restaurant-info/add-or-update");
        model.addAttribute("sucMsg", sucMsg);
        return "restaurant-add-info-account";
    }

}
