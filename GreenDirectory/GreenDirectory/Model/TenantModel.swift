//
//  TenantModel.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import Foundation
import SwiftData

@Model
class Tenant: Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    var category: String
    var phone: String
    
    @Relationship(deleteRule: .cascade, inverse: \Menu.tenant)
        var menus: [Menu] = []
    
    init(id: String, name: String, category: String, phone: String) {
        self.id = id
        self.name = name
        self.category = category
        self.phone = phone
    }
}
