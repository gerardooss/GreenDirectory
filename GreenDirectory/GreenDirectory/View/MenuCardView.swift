//
//  menuCard.swift
//  GreenDirectory
//
//  Created by Georgius Kenny Gunawan on 27/03/25.
//

import SwiftUI

struct MenuCardView: View {
    
    @State var menuName: String
    @State var menuImage: String
    @State var menuPrice: Int
    
    var body: some View {
        Button {
            
        } label: {
            VStack{
                Image(menuImage)
                    .resizable()
                    .frame(width: 135, height: 108)
                    .padding(.top, 10)
                
                HStack{
                    Text(menuName)
                        .font(.system(size: 14))
                    Spacer()
                    Image(systemName: "heart")
                        .foregroundStyle(.red)
                    Spacer()
                        .frame(width: 21)
                }
                .padding(.leading, 22)
                HStack{
                    Text("Rp. \(menuPrice)")
                        .font(.system(size: 14))
                        .padding(.bottom, 5)
                    Spacer()
                }.padding(.leading, 22)
                
                
            }
            .frame(width: 180, height: 180)
            .background(Color(.white))
            .cornerRadius(2)
            .shadow(color: .gray, radius: 3, y: 5)
        }.buttonStyle(PlainButtonStyle())

        
    }
}

#Preview {
    MenuCardView(menuName: "Food Name", menuImage: "Leppy", menuPrice: 5000)
}
