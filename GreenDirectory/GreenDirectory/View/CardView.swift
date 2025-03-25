//
//  CardView.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import SwiftUI

struct CardView: View {
    @State var tenantName: String
    
    var body: some View {
        HStack {
            Image("")
                .frame(width: 68, height: 68)
                .background(Circle().fill(Color.blue))
                .clipShape(Circle())
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
        .background(Rectangle().fill(Color.white))
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3, x: 2, y: 2)
    }
}

#Preview {
    CardView(tenantName: "Tenant A")
}
