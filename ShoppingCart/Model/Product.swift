//
//  Item.swift
//  ShoppingCart
//
//  Created by Pedro Valderrama on 31/01/2022.
//

import Foundation

class Product {
    var ID: String
    var name: String
    var price: Int
    var stock: Int
    
    init ( id: String, name: String, price: Int, stock: Int) {
        ID = id
        self.name = name
        self.price = price
        self.stock = stock
    }
}
