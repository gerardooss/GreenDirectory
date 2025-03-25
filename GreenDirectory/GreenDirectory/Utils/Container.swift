//
//  Container.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import Foundation
import SwiftData

actor Container {
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        var tenantMap: [String: Tenant] = [:]
        let schema = Schema([Tenant.self, Menu.self])
        let configuration = ModelConfiguration()
        let container: ModelContainer
        
        do {
            container = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
        
        if shouldCreateDefaults {
            let tenants = TenantJSONDecoder.decode(from: "tenants")
            if tenants.isEmpty == false {
                tenants.forEach { i in
                    let tenantObject = Tenant(
                        id: i.id,
                        name: i.name,
                        category: i.name,
                        phone: i.phone
                    )
                    
                    container.mainContext.insert(tenantObject)
                    tenantMap[i.id] = tenantObject
                    print("Tenant inserted: \(tenantObject.name), ID: \(tenantObject.id)")
                }
            }
            
            let menus = MenuJSONDecoder.decode(from: "menus")
            if menus.isEmpty == false {
                menus.forEach { i in
                    guard let tenant = tenantMap[i.tenantId] else {
                        print("Error: Tenant not found.")
                        return
                    }
                    
                    let menuObject = Menu(
                        id: i.id,
                        name: i.name,
                        category: i.category,
                        ingredient: i.ingredient,
                        taste: i.taste,
                        price: i.price,
                        tenant: tenant
                    )
                    container.mainContext.insert(menuObject)
                }
            }
            shouldCreateDefaults = false
        }
        return container
    }
}
