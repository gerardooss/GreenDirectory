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
    @State var tenantCategory: String
        
    var body: some View {
        HStack {
            Image(tenantId)
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .background(Circle().fill(Color.theme))
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
                    
                    Text(tenantCategory)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
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
    CardView(tenantName: "Tenant A", tenantCategory: "Korean")
}
