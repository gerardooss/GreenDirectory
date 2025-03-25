//
//  MenuModel.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import Foundation
import SwiftData

@Model
class Menu: Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    var category: String
    var ingredient: String
    var taste: String
    var price: Double
    var tenant: Tenant?
    
    init (
        id: String,
        name: String,
        category: String,
        ingredient: String,
        taste: String,
        price: Double,
        tenant: Tenant?
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.ingredient = ingredient
        self.taste = taste
        self.price = price
        self.tenant = tenant
    }
}
