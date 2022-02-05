//
//  ProductListTableViewCell.swift
//  ShoppingCart
//
//  Created by Pedro Valderrama on 31/01/2022.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    var seletedProduct: Product?
    weak var buyDelegate: Buyable?
    
    @IBOutlet weak var productNameLable: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productStockCounterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(product: Product, delegate: Buyable?) {
        
        productNameLable.text = product.name
        productPriceLabel.text = "$ \(product.price)"
        productStockCounterLabel.text = "\(product.stock)"
        self.seletedProduct = product
        self.buyDelegate = delegate
    }
    
    @IBAction func buyProductTapBotton(_ sender: Any) {
        buyDelegate?.buy(seletedProduct!)
    }

}
