//
//  ShoppingCartTableViewCell.swift
//  ShoppingCart
//
//  Created by Pedro Valderrama on 01/02/2022.
//

import UIKit
protocol DeleteProduct: AnyObject {
    func deletedProduct(_ product: ProductInCart)
}

class ShoppingCartTableViewCell: UITableViewCell {
    
    var seletedProduct: ProductInCart?
    weak var productToDelete: DeleteProduct?
    
    @IBOutlet weak var nameProductInCartLabel: UILabel!
    @IBOutlet weak var priceProductInCartLabel: UILabel!
    @IBOutlet weak var counterProductLabel: UILabel!

    func setData(_ product: ProductInCart, _ delegate: DeleteProduct) {
        nameProductInCartLabel.text = product.selectedProduct.name
        priceProductInCartLabel.text = "$ \(product.total)"
        counterProductLabel.text = "\(product.count)"
        productToDelete = delegate
        seletedProduct = product
    }
        
    @IBAction func deleteToCartBottonTap(_ sender: Any) {
        productToDelete?.deletedProduct(seletedProduct!)
    }
}
