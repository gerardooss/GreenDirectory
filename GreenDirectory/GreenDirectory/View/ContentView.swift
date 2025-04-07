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
    
    @FocusState private var isSearchFieldFocused: Bool
    @State private var searchText = ""
    @State private var isNavigating = false
    
    var columns: [GridItem] = [GridItem(.flexible())]
    
    var suggestions: [String] {
        let baseSuggestions = ["Ayam", "Bakso", "Pecel", "Soto", "Mi", "Nasi", "Telur", "Kentang"]
        
        if searchText.isEmpty {
            return []
        } else {
            let filtered = baseSuggestions
                .filter { $0.localizedCaseInsensitiveContains(searchText) }
            
            if filtered.isEmpty {
                return [searchText]
            } else {
                return filtered
            }
        }
    }
    
    var body: some View {
        let sortedTenants = tenantsFromLocal.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }

        NavigationStack {
            VStack {
                ScrollView {
                    if isSearchFieldFocused {
                        HStack {
                            Text("Start typing to search...")
                                .foregroundColor(.gray)
                                .italic()
                            Spacer()
                        }
                        .padding(.horizontal)
                    } else {
                        HStack {
                            Text("Tenant List")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        .padding(.top, 8)
                        
                        LazyVGrid(columns: columns) {
                            tenantsListView(tenants: sortedTenants)
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "🍜 What are you craving?")
                .searchFocused($isSearchFieldFocused)
                .searchSuggestions {
                    ForEach(suggestions, id: \.self) { suggestion in
                        Button {
                            searchText = suggestion
                            isNavigating = true
                        } label: {
                            HStack{
                                Image(systemName: "fork.knife.circle.fill")
                                Text(suggestion)
                            }
                        }
                    }
                }
                .onSubmit(of: .search) {
                    isNavigating = true
                    searchText = ""
                }
                .navigationDestination(isPresented: $isNavigating) {
                    // TODO
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Discover")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: FavoriteView()) {
                            Image(systemName: "heart.circle")
                                .foregroundColor(Color.iconGreen)
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .tint(Color.iconGreen)
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
                destination: MenuView(tenantId: tenant.id, tenantName: tenant.name, tenantContact: tenant.phone, tenantDesc: tenant.desc),
                label: { CardView(tenantName: tenant.name, tenantId: tenant.id, tenantCategory: tenant.category) }
            )
            .padding(.bottom, 4)
        }
    }
}

#Preview {
    ContentView()
}
