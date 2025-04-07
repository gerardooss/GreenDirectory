//
//  ContentView.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var tenantsFromLocal: [Tenant]
    @Query private var menusFromLocal: [Menu]
    
    @FocusState private var isSearchFieldFocused: Bool
    @State private var searchText = ""
    @State private var selection = "Tenants"
    
    var columns: [GridItem] {
        if selection == "Tenants" {
            return [GridItem(.flexible())]
        } else {
            return Array(repeating: .init(.flexible()), count: 2)
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                if isSearchFieldFocused {
                    Picker("Selection", selection: $selection) {
                        Text("Tenants").tag("Tenants")
                        Text("Foods").tag("Foods")
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .animation(.easeIn(duration: 0.17))
                }
                
                ScrollView{
                    LazyVGrid(columns: columns) {
                        contentForLazyVGrid
                    }
                    .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
                    .searchFocused($isSearchFieldFocused)
                    .onChange(of: isSearchFieldFocused) { newValue in
                        if !newValue && searchText.isEmpty {
                            selection = "Tenants"
                        }
                    }
                    .padding(12)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text(selection == "Tenants" ? "Tenants" : "Foods")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                // TODO
                            }) {
                                NavigationLink(destination: {
                                    FavoriteView()
                                }, label: {
                                    Image(systemName: "heart.circle")
                                        .foregroundColor(Color.iconGreen)
                                        .font(.title2)
                                })
                            }
                        }
                    }
                }
            }
        }
        .tint(Color.iconGreen)
    }
    
    @ViewBuilder
    private var contentForLazyVGrid: some View {
        // Filter tenant & menu
        let filteredTenants = tenantsFromLocal.filter { tenant in
            searchText.isEmpty || tenant.name.localizedCaseInsensitiveContains(searchText)
        }
        let filteredMenus = menusFromLocal.filter { menu in
            searchText.isEmpty || menu.name.localizedCaseInsensitiveContains(searchText) ||
            menu.searchKeyWord.localizedCaseInsensitiveContains(searchText)
        }
        
        // Empty result for tenant & menu
        let showNoTenantsResults = selection == "Tenants" && filteredTenants.isEmpty && !searchText.isEmpty
        let showNoFoodsResults = selection == "Foods" && filteredMenus.isEmpty && !searchText.isEmpty
        
        if selection == "Tenants" {
            if showNoTenantsResults {
                noResultsView
            } else {
                tenantsListView(tenants: filteredTenants)
            }
        } else {
            if showNoFoodsResults {
                noResultsView
            } else {
                foodsListView(menus: filteredMenus)
            }
        }
    }
    
    private var noResultsView: some View {
        VStack {
            Spacer().padding(.top, 42)
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(Color.gray)
            Text("No result for \"\(searchText)\"")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top, 4)
            Text("Try a different search.")
                .font(.subheadline)
                .foregroundColor(Color.gray)
        }
    }
    
    private func tenantsListView(tenants: [Tenant]) -> some View {
        ForEach(tenants) { tenant in
            NavigationLink(
                destination: MenuView(tenantId: tenant.id, tenantName: tenant.name, tenantContact: tenant.phone, tenantDesc: ""),
                label: { CardView(tenantName: tenant.name, tenantId: tenant.id, tenantCategory: tenant.category) }
            )
            .padding(.bottom, 4)
        }
    }
    
    private func foodsListView(menus: [Menu]) -> some View {
        ForEach(menus) { menu in
            NavigationLink(
                destination: DetailView(menu: menu),
                label: { MenuCardView(menu: menu) }
            )
            .padding(.bottom, 4)
        }
    }
}

#Preview {
    ContentView()
}
