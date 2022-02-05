//
//  ViewController.swift
//  ShoppingCart
//
//  Created by Pedro Valderrama on 31/01/2022.
//

import UIKit

class ProductListViewController: UIViewController {

    var products: [Product] = []
    var totalPrice = 0
    var cartCounter = 0
    var shoppingCartList: [ProductInCart] = []
    
    @IBOutlet weak var productListTableView: UITableView!
    @IBOutlet weak var productsTotalPriceLabel: UILabel!
    @IBOutlet weak var productsInCartCounterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsTotalPriceLabel.text = "$ \(totalPrice)"
        productsInCartCounterLabel.text = "\(cartCounter)"
        productListTableView.dataSource = self
        let cellNib = UINib(nibName: String(describing: ProductListTableViewCell.self), bundle: nil)
        productListTableView.register(cellNib, forCellReuseIdentifier: "productlistcell")
        products = createDummyProducts()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                productListTableView.reloadData()
    }
    
    func createDummyProducts() -> [Product] {
        
        products.append(.init(id: "1", name: "Burguer", price: 4, stock: 6))
        products.append(.init(id: "2",name: "Fries", price: 2, stock: 6))
        products.append(.init(id: "3",name: "Pizza", price: 6, stock: 6))
        products.append(.init(id: "4",name: "Chori", price: 3, stock: 6))
        products.append(.init(id: "5",name: "Coke", price: 1, stock: 6))
        return products
    }
    
    func setStockData(_ selectedProduct: Product) {

        if selectedProduct.stock > 0 {
            selectedProduct.stock -= 1
        } else if selectedProduct.stock <= 0 {
           selectedProduct.stock = 0
            }
        productListTableView.reloadData()
    }
    
    func setTotalAndPriceLabel(_ selectedProduct: Product) {
            
            totalPrice += selectedProduct.price
            cartCounter += 1
            productsTotalPriceLabel.text = "$ \(totalPrice)"
            productsInCartCounterLabel.text = "\(cartCounter)"
    }
    
    func addProduct(_ product: Product, count: Int) {
    
        if let productInCart = shoppingCartList.first(where: { $0.selectedProduct.ID == product.ID}){
            productInCart.count += count
        } else {
            let newCartProduct = ProductInCart(product, count: count)
            shoppingCartList.append(newCartProduct)
        }
    }
    
    func cellDelete(_ selectedProduct: Product) {
        guard let productIndex = products.firstIndex(where: { $0.ID == selectedProduct.ID }) else {
            return
        }
        if selectedProduct.stock == 0 {
            products.remove(at: productIndex)
            productListTableView.reloadData()
        }
        return
    }
    
    @IBAction func shoppingCartTapButton(_ sender: Any) {
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ShoppingCart = segue.destination as? ShoppingCartViewController {
            ShoppingCart.productsInCart = shoppingCartList
        }
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productlistcell") as? ProductListTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(product: products[indexPath.row], delegate: self)
        return cell
    }
}

extension ProductListViewController: Buyable {
   
        func buy(_ product: Product) {
        addProduct(product, count: 1)
        setStockData(product)
        setTotalAndPriceLabel(product)
        cellDelete(product)
    }
}

