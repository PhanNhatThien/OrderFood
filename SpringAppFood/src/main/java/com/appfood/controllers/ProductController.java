package com.appfood.controllers;


import com.appfood.pojo.Category;
import com.appfood.pojo.Product;
import com.appfood.pojo.Restaurant;
import com.appfood.pojo.User;
import com.appfood.service.CategoryService;
import com.appfood.service.ProductService;
import com.appfood.service.RestaurantService;
import com.appfood.service.UserService;
import com.appfood.utils.Utils;
import com.appfood.validator.ProductValidator;
import org.springframework.beans.factory.annotation.Autowired;
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
public class ProductController {
    @Autowired
    UserService userService;

    @Autowired
    ProductService productService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    RestaurantService restaurantService;

    @Autowired
    ProductValidator productValidator;

    private void loadAllList(Model model) {
        List<User> users = userService.getByRole(User.NHAHANG, 0, 1);
        model.addAttribute("users", users);
        List<Category> categories = categoryService.getCategories("", 0);
        model.addAttribute("categories", categories);
    }

    @RequestMapping(value = "/admin/product-post")
    public String index(Model model,
                        @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        String name = params.getOrDefault("name", null);
        String description = params.getOrDefault("description", null);
        String price = params.getOrDefault("price", null);

        Map<String, String> pre = new HashMap<>();
        if (name != null) {
            pre.put("name", name);
            model.addAttribute("name", name);
        }
        if (description != null) {
            pre.put("description", description);
            model.addAttribute("description", description);
        }
        if (price != null) {
            pre.put("price", price);
            model.addAttribute("price", price);
        }


        List<Product> products = productService.getProducts(pre, page);
        List<Product> productsSize = productService.getProducts(pre, 0);
        model.addAttribute("products", products);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", productsSize.size());
        model.addAttribute("productService", productService);

        // another
        model.addAttribute("userService", userService);
        model.addAttribute("categoryService", categoryService);
        model.addAttribute("restaurantService", restaurantService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "admin-product-post";
    }

    @GetMapping("/admin/product-post/view")
    public String viewProduct(Model model,
                              @RequestParam(name = "id", defaultValue = "0") int id) {
        if (id > 0) {
            model.addAttribute("product", this.productService.getProductById(id));
            model.addAttribute("userService", userService);
            model.addAttribute("categoryService", categoryService);
            model.addAttribute("restaurantService", restaurantService);
        } else {
            return "redirect:/admin/product-post";
        }
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "view-product-post";
    }

    @GetMapping("/admin/product-post/add-or-update")
    public String addOrUpdateProductView(Model model,
                                         @RequestParam(name = "id", defaultValue = "0") int id) {

        if (id > 0)
            model.addAttribute("product", this.productService.getProductById(id));
        else {
            Product product = new Product();
            product.setId(0);
            model.addAttribute("product", product);

        }

        loadAllList(model);
        model.addAttribute("restaurantService", restaurantService);
        return "add-product-post";
    }


    @PostMapping(value = "/admin/product-post/add-or-update")
    public String addOrUpdateProduct(Model model,
                                     @ModelAttribute(value = "product") @Valid Product product,
                                     BindingResult result,
                                     final RedirectAttributes redirectAttrs) throws ParseException {
        String errMsg = null;
        String sucMsg = null;

        loadAllList(model);

        productValidator.validate(product, result);
        if (result.hasErrors())
            return "add-product-post";

        product.setPostedByUser(userService.getUserById(product.getPostedByUserId()));
        product.setCategoryId(categoryService.getById(product.getCategoryById()));
        product.setCreatedDate(new Date());

        boolean productAddedCheck = this.productService.addOrUpdate(product);
        if (productAddedCheck) {
            if (product.getId() == 0)
                sucMsg = String.format("Thêm thành công bài viết '%s'", product.getName());
            else
                sucMsg = String.format("Sửa thành công bài viết '%s'", product.getName());
        } else {
            if (product.getId() == 0)
                errMsg = String.format("Thêm bài viết '%s' thất bại", product.getName());
            else
                errMsg = String.format("Sửa bài viết '%s' thất bại", product.getName());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/product-post";
    }

    @GetMapping(path = "/admin/product-post/delete")
    public String deleteProduct(Model model,
                                    @RequestParam(name = "id", defaultValue = "0") int id,
                                    final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;
        Product product = new Product();

        if (id > 0)
            product = this.productService.getProductById(id);

        boolean deleteCheck = productService.delete(product);
        if (product != null && deleteCheck) {
            sucMsg = String.format("Xoá thành công món'%s'", product.getName());
        } else {
            assert product != null;
            errMsg = String.format("Xoá không thành công món '%s'", product.getName());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/product-post";
    }

}
