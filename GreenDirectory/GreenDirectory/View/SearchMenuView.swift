//
//  SearchMenuView.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 07/04/25.
//

import SwiftUI
import SwiftData

struct SearchMenuView: View {
    
    var searchQuery: String
    @Query private var allMenus: [Menu]
    
    var menuResult: [Menu] {
        allMenus.filter {
            $0.name.localizedStandardContains(searchQuery) ||
            $0.ingredient.localizedStandardContains(searchQuery)
        }
    }
    
    var groupedResult: [Tenant: [Menu]] {
        Dictionary(grouping: menuResult) { $0.tenant! }
    }
    
    var body: some View {
        if menuResult.isEmpty {
            noResultsView
        } else {
            NavigationStack {
                ScrollView {
                    HStack {
                        Text("Showing results for \(searchQuery)")
                            .foregroundColor(Color.gray)
                            .font(.subheadline)
                            .padding(.horizontal)
                            .italic()
                        Spacer()
                    }
                    
                    ForEach(groupedResult.keys.sorted(by: { $0.name < $1.name }), id: \.id) { tenant in
                        if let menus = groupedResult[tenant] {
                            VStack(alignment: .leading, spacing: 2) {
                                NavigationLink(destination: MenuView(tenantId: tenant.id, tenantName: tenant.name, tenantContact: tenant.phone, tenantDesc: tenant.desc)) {
                                    Text(tenant.name)
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(Color.themeInverse)
                                        .padding(.leading)
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .bold))
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(menus) { menu in
                                            NavigationLink(destination: DetailView(menu: menu)) {
                                                MenuCardView(menu: menu)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.bottom, 16)
                            }
                        }
                    }
                }
                .background(Color.theme)
            }
        }
    }
    
    private var noResultsView: some View {
        VStack {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(Color.gray)
            Text("No result for \"\(searchQuery)\"")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top, 4)
            Text("Try a different search.")
                .font(.subheadline)
                .foregroundColor(Color.gray)
            Spacer()
        }
    }
}

#Preview {
    SearchMenuView(searchQuery: "Hutan")
}
