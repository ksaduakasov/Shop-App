//
//  Item.swift
//  SimpleShopApp
//
//  Created by Kalbek Saduakassov on 02.02.2021.
//

import Foundation

public class Item {
    var image: String?
    var title: String?
    var author: String?
    var description: String?
    var price: Float?
    var discount: Int?
    

    public init(image: String, title: String, author: String, description: String, price: Float, discount: Int) {
        self.image = image
        self.title = title
        self.author = author
        self.description = description
        self.price = price
        self.discount = discount
        
    }
}


