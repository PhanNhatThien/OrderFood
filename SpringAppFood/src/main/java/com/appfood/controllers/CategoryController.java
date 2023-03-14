package com.appfood.controllers;

import com.appfood.pojo.Category;
import com.appfood.pojo.Product;
import com.appfood.pojo.User;
import com.appfood.service.CategoryService;
import com.appfood.validator.CategoryValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
public class CategoryController{

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CategoryValidator categoryValidator;

    @RequestMapping("/admin/category")
    public String manageCategory(Model model,
                               @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));

        List<Category> categories = this.categoryService.getCategories("", page);
        model.addAttribute("categories", categories);

        model.addAttribute("currentPage", page);
        model.addAttribute("counter", categoryService.count());
        model.addAttribute("categoryService", categoryService);
        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        model.addAttribute("sucMsg", model.asMap().get("sucMsg"));

        return "admin-manage-category";
    }


    @GetMapping("/admin/category/add-or-update")
    public String addOrUpdateCategoryView(Model model,
                                         @RequestParam(name = "id", defaultValue = "0") int id) {


        if (id > 0) {
            model.addAttribute("category", this.categoryService.getById(id));
        } else {
            Category category = new Category();
            category.setId(0);
            model.addAttribute("category", category);
        }

        model.addAttribute("errMsg", model.asMap().get("errMsg"));
        return "add-category";
    }

    @PostMapping("/admin/category/add-or-update")
    public String addOrUpdateCategory(Model model,
                                     @ModelAttribute(value = "category") @Valid Category category,
                                     BindingResult result,
                                     final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        categoryValidator.validate(category, result);
        if (result.hasErrors())
            return "add-category";

        boolean categoryAddedCheck = this.categoryService.addOrUpdate(category);
        if (categoryAddedCheck) {
            if (category.getId() == 0)
                sucMsg = String.format("Thêm thông tin danh mục '%s' thành công", category.getName());
            else
                sucMsg = String.format("Sửa thông tin danh mục '%s' thành công", category.getName());
        } else {
            if (category.getId() == 0)
                errMsg = String.format("Thêm thông tin danh mục '%s' không thành công", category.getName());
            else
                errMsg = String.format("Sửa thông tin danh mục '%s' không thành công", category.getName());
        }

        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/category";
    }


    @GetMapping(path = "/admin/category/delete")
    public String deleteCategoryById(Model model,
                                    @RequestParam(value = "id", defaultValue ="0") int id,
                                    final RedirectAttributes redirectAttrs) {
        String errMsg = null;
        String sucMsg = null;

        Category category = new Category();
        if (id > 0) {
            category = this.categoryService.getById(id);
        }

        boolean deleteCheck = categoryService.delete(category);

        if (category != null && deleteCheck)
            sucMsg = String.format("Xoá danh mục '%s' thành công", category.getName());
        else
            errMsg = String.format("Xoá danh mục '%s' không thành công", category.getName());


        redirectAttrs.addFlashAttribute("errMsg", errMsg);
        redirectAttrs.addFlashAttribute("sucMsg", sucMsg);
        return "redirect:/admin/category";
    }

}
