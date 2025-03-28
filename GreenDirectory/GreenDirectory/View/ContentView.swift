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
    
    let columns: [GridItem] = Array(repeating:
            .init(.flexible()), count: 1)
    
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
                        if selection == "Tenants" {
                            let filteredTenants = tenantsFromLocal.filter { tenant in
                                searchText.isEmpty || tenant.name.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            if filteredTenants.isEmpty {
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
                                
                            } else {
                                ForEach(filteredTenants, id: \.self) { tenant in
                                    NavigationLink(
                                        destination: DetailView(tenantName: tenant.name),
                                        label: { CardView(tenantName: tenant.name, tenantId: tenant.id) }
                                    )
                                }
                                .padding(.bottom, 4)
                            }
                        } else {
                            let filteredMenus = menusFromLocal.filter { menu in
                                searchText.isEmpty || menu.name.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            if filteredMenus.isEmpty {
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
                            } else {
                                ForEach(filteredMenus, id: \.self) { menu in
                                    NavigationLink(
                                        destination: DetailView(tenantName: menu.name),
                                        label: { CardView(tenantName: menu.name) }
                                    )
                                    .padding(.bottom, 4)
                                }
                            }
                        }
                    }
                    .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
                    .searchFocused($isSearchFieldFocused)
                    .padding(12)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Tenants")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                // TODO
                            }) {
                                Image(systemName: "heart.circle")
                                    .foregroundColor(Color.iconGreen)
                                    .font(.title2)
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, 12)
        .tint(Color.iconGreen)
    }
}

#Preview {
    ContentView()
}
