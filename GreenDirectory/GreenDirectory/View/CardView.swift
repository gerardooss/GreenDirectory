//
//  CardView.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import SwiftUI

struct CardView: View {
    @State var tenantName: String
    @State var tenantId: String = ""
        
    var body: some View {
        HStack {
            Image(tenantId)
                .resizable()
                .scaledToFill()
                .frame(width: 68, height: 68)
                .background(Circle().fill(Color.themeInverse))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.theme, lineWidth: 3))
                .padding(.trailing, 6)
            
            Spacer()
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(tenantName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text("Price")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.cardBG)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.4), radius: 2, x: 1, y: 2)
    }
}

#Preview {
    CardView(tenantName: "Tenant A")
}
