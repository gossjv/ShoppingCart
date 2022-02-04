//
//  ProductInCart.swift
//  ShoppingCart
//
//  Created by Pedro Valderrama on 01/02/2022.
//

import Foundation

class ProductInCart {
    
    var selectedProduct: Product
    var count: Int
    var total: Int {
        selectedProduct.price * count
    }
//    weak var buyDelegate: Buyable?

    init(_ product: Product, count: Int) {
        selectedProduct = product
        self.count = count
    }
}
