//
//  ContentView.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var tenantsFromLocal: [Tenant]
    @Query private var menusFromLocal: [Menu]
    
    let columns: [GridItem] = Array(repeating:
            .init(.flexible()), count: 1)
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    LazyVGrid(columns: columns) {
                        ForEach(tenantsFromLocal.filter { item in
                            searchText.isEmpty || item.menus.contains(where: { menu in
                                menu.name.localizedCaseInsensitiveContains(searchText)
                            })
                        }, id: \.self)
                        { tenant in
                            NavigationLink(
                                destination: DetailView(tenantName: tenant.name),
                                label: {CardView(tenantName: tenant.name)})
                        }
                    }
                    .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
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
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, 2)
        
    }
}

#Preview {
    ContentView()
}
