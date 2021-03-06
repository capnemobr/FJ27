package br.com.casadocodigo.loja.controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.casadocodigo.loja.daos.ProductDAO;
import br.com.casadocodigo.loja.infra.FileSaver;
import br.com.casadocodigo.loja.models.BookType;
import br.com.casadocodigo.loja.models.Product;

@Controller
@RequestMapping("/products")
public class ProductsController {
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private FileSaver fileSaver;

//  Exercicio 5.8 retirar para usar o BEAN VALIDATION do Spring
//	@InitBinder
//	public void initBinder(WebDataBinder webDataBinder) {
//		webDataBinder.addValidators(new ProductValidator());
//	}
	
	@RequestMapping("/form")
	public ModelAndView form(Product product) {
		ModelAndView modelAndView = new ModelAndView("products/form");
		modelAndView.addObject("types", BookType.values());
		return modelAndView;
	}
	
    @RequestMapping(method=RequestMethod.POST)
    @Transactional
    @CacheEvict(value="lastProducts", allEntries=true)
    public ModelAndView save(@Valid Product product,BindingResult bindingResult, RedirectAttributes redirectAttributes,
    		                 MultipartFile summary) {
        
    	if(bindingResult.hasErrors()) {
    		return form(product);
    	}
    	
        String webPath = fileSaver.write("uploaded-summaries",summary);
        product.setSummaryPath(webPath);
    	
    	productDAO.save(product);    	
    	System.out.println("Cadastrando o produto: " +product);
    	redirectAttributes.addFlashAttribute("sucesso", "Produto cadastrado com sucesso");
    	        
        return new ModelAndView("redirect:products");
    }
    
    @RequestMapping(method=RequestMethod.GET)
    @Cacheable(value="lastProducts")
    public ModelAndView list() {
    	ModelAndView modelAndView = new ModelAndView("products/list");
    	modelAndView.addObject("products", productDAO.list());
    	return modelAndView;
    }
    
    @RequestMapping(method=RequestMethod.GET, value="/{id}")
    public ModelAndView show(@PathVariable("id") Long id) {
        ModelAndView modelAndView = new ModelAndView("products/show");
        modelAndView.addObject("product", productDAO.find(id));
        return modelAndView;
    }

}
