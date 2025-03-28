
//  MenuView.swift
//  GreenDirectory
//
//  Created by Georgius Kenny Gunawan on 26/03/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct MenuView: View {
    @State var searchText: String = ""
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    @Environment(\.modelContext) private var context
    @Query private var tenantsFromLocal: [Tenant]
    @Query private var menusFromLocal: [Menu]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    HStack {
                        Image("Leppy")
                            .resizable()
                            .frame(width: 150, height: 200)
                            .scaledToFill()
                            .clipShape(.circle)
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 3)
                            )
                            .padding(.leading, 20)
                        
                        
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Kasturi")
                                .font(.headline)
                            Text("CP +62287391928")
                                .font(.caption)
                                .padding(.bottom, 1)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed pellentesque justo. Praesent vulputate tincidunt nibh a vulputate. Cras tincidunt nunc at luctus pulvinar")
                                .font(.system(size: 13))
                                .lineLimit(4)
                        }
                        .frame(width: 170)
                        Spacer()
                    }
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.black)
                    
                    LazyVGrid(columns: columns, alignment: .leading) {
                        ForEach(tenantsFromLocal, id: \.self) { tenant in
                            ForEach(menusFromLocal.filter { $0.tenant.id == tenant.id }, id: \.self) { menu in
                                MenuCardView(menuName: menu.name, menuImage: "Leppy", menuPrice: Int(menu.price))
                            }
                        }
                    }

                    .padding(.horizontal)
                    .padding(.top, 5)
                }
            }
            .searchable(text: $searchText, prompt: "Cari Menu")
            .navigationTitle("Daftar Tenant")
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
        
        
        
    }
}

#Preview {
    MenuView()
}
