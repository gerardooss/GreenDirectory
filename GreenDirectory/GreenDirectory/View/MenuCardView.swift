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
        VStack {
            Image(menu.id) // or menu.imageName if you have a separate image field
                .resizable()
                .frame(width: 135, height: 108)
                .padding(.top, 10)
            
            HStack {
                Text(menu.name)
                    .font(.system(size: 14, weight: .bold))
                Spacer()
                Image(systemName: menu.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                Spacer()
                    .frame(width: 21)
            }
            .padding(.leading, 22)
            
            HStack {
                Text("Rp. \(Int(menu.price))")
                    .font(.system(size: 14))
                    .padding(.bottom, 5)
                Spacer()
            }
            .padding(.leading, 22)
        }
        .frame(width: 180, height: 180)
        .background(Color.white)
        .cornerRadius(2)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .border(Color.black.opacity(0.2))


        
    }
}

#Preview {
    let sampleTenant = Tenant(id: "t1", name: "Sample Tenant", category: "Cafe", phone: "123456")
    let sampleMenu = Menu(
        id: "m1",
        name: "Leppy",
        category: "Food",
        ingredient: "Choco",
        taste: "Sweet",
        price: 5000,
        tenant: sampleTenant,
        isFavorite: true
    )
    
    return MenuCardView(menu: sampleMenu)
}





