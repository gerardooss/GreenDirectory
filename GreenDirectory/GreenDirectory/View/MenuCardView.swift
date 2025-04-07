//
//  menuCard.swift
//  GreenDirectory
//
//  Created by Georgius Kenny Gunawan on 27/03/25.
//

import SwiftUI

struct MenuCardView: View {
    
    var menu: Menu
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(menu.id)
                .resizable()
                .frame(width: 164, height: 118)
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.2))
                )
                .padding(.top, 8)
                .padding(.horizontal, 8)
            
            HStack {
                Text(menu.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.themeInverse)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: menu.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
            .padding(.horizontal, 12)
            
            VStack(alignment: .leading) {
                Text(menu.ingredient)
                    .font(.system(size: 11))
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 2)
                
                Text("Rp \(Int(menu.price))")
                    .font(.system(size: 11))
                    .foregroundColor(Color.gray)
                
            }
            .padding(.horizontal, 12)
            
            Spacer()
            
        }
        .frame(width: 180, height: 190)
        .background(Color.cardBG)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 2)
    }
}

#Preview {
    let sampleTenant = Tenant(id: "t1", name: "Sample Tenant", category: "Cafe", phone: "123456", desc: "Sample Desc")
    let sampleMenu = Menu(
        id: "57",
        name: "Leppy",
        category: "Food",
        ingredient: "Choco",
        taste: "Sweet",
        price: 5000,
        tenant: sampleTenant,
        isFavorite: true
    )
    
    MenuCardView(menu: sampleMenu)
}
