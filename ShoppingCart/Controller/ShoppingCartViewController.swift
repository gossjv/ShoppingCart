//
//  ShoppingCart.swift
//  ShoppingCart
//
//  Created by Pedro Valderrama on 01/02/2022.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    var productsInCart: [ProductInCart] = []
    var deletedProducts: [Product] = []

    @IBOutlet weak var shoppingCartListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartListTableView.dataSource = self
        let cellNib = UINib(nibName: String(describing: ShoppingCartTableViewCell.self), bundle: nil)
        shoppingCartListTableView.register(cellNib, forCellReuseIdentifier: "shoppingcartcell")
    }
    
    func setCellData(_ product: ProductInCart) {
        
        if let productToDelete = productsInCart.first(where: { $0.selectedProduct.ID == product.selectedProduct.ID}){
            if productToDelete.count >= 1 {
                productToDelete.count -= 1
                productToDelete.selectedProduct.stock += 1
                shoppingCartListTableView.reloadData()
            }
            if productToDelete.count == 0 {
                guard let productIndex = productsInCart.firstIndex(where: { $0.selectedProduct.ID == product.selectedProduct.ID }) else {
                    return
                }
                let indexPaths = [IndexPath(row: productIndex, section: 0)]
                productsInCart.remove(at: productIndex)
                shoppingCartListTableView.deleteRows(at: indexPaths, with: .automatic)
                shoppingCartListTableView.reloadData()
            }
        }
    }
}

extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingcartcell") as! ShoppingCartTableViewCell
        cell.setData(productsInCart[indexPath.row], self)
        return cell
    }
}

extension ShoppingCartViewController: DeleteProduct {
    func deletedProduct(_ product: ProductInCart) {
        setCellData(product)
    }
}
