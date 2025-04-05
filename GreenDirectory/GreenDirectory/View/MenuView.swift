
//  MenuView.swift
//  GreenDirectory
//
//  Created by Georgius Kenny Gunawan on 26/03/25.
//

import SwiftUI
import SwiftData

struct MenuView: View {
    @Environment(\.modelContext) private var context
    @Query private var menusFromLocal: [Menu]
    @State var searchText: String = ""
    
    var tenantId: String
    var tenantName: String
    var tenantContact: String
    var tenantDesc: String
    
    var foodFilteredView: [Menu] {
            let menuPerTenant = menusFromLocal.filter { $0.tenant?.id == tenantId }
            guard !searchText.isEmpty else { return menuPerTenant }
            
            return menuPerTenant.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    HStack {
                        Image(tenantId)
                            .resizable()
                            .frame(width: 130, height: 130)
                            .scaledToFill()
                            .clipShape(.circle)
                            .overlay(
                                Circle().stroke(
                                    Color.black.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.leading, 20)
                            .padding(.vertical, 8)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text(tenantName)
                                .font(.headline)
                            Text(tenantContact)
                                .font(.subheadline)
                                .foregroundStyle(Color.gray)
                                .padding(.bottom, 1)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed pellentesque justo. ")
                                .font(.system(size: 12))
                                .lineLimit(4)
                        }
                        .padding(.leading, 4)
                        
                        Spacer()
                    }
                    .padding(.trailing, 4)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.black.opacity(0.3))
                    
                    LazyVGrid(columns: columns, alignment: .leading) {
                        ForEach(menusFromLocal) { menu in
                            if menu.tenant?.id == tenantId &&
                               (searchText.isEmpty || menu.name.lowercased().contains(searchText.lowercased())) {
                                
                                NavigationLink(destination: DetailView(menu: menu)) {
                                    MenuCardView(menu: menu)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                    
                }
            }
            .searchable(text: $searchText)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                       
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .tint(Color.iconGreen)
    }
}

#Preview {
    MenuView(tenantId: "t1",
             tenantName: "Ahza Snack & Beverages",
             tenantContact:"12341412",
             tenantDesc: "")
}
