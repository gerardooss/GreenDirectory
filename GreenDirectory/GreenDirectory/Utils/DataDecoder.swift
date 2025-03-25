//
//  DataDecoder.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import Foundation

struct TenantResponse: Decodable {
    var id: String
    var name: String
    var category: String
    var phone: String
}

struct MenuResponse: Decodable {
    var id: String
    var name: String
    var category: String
    var ingredient: String
    var taste: String
    var price: Double
    var tenantId: String
}

struct TenantJSONDecoder{
    static func decode(from fileName: String) -> [TenantResponse] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let tenants = try? JSONDecoder().decode([TenantResponse].self, from: data) else { return [] }
        
        return tenants
    }
}

struct MenuJSONDecoder{
    static func decode(from fileName: String) -> [MenuResponse] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let menus = try? JSONDecoder().decode([MenuResponse].self, from: data) else { return [] }
        
        return menus
    }
}
