//
//  favoriteCardView.swift
//  GreenDirectory
//
//  Created by Georgius Kenny Gunawan on 30/03/25.
//

import SwiftUI

struct favoriteCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Kasturi")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) { 
                    ForEach(0..<3, id: \.self) { _ in
//                        MenuCardView(menuName: "a", menuImage: "", menuPrice: 500, isFavorite: .constant(false))
                    }
                }

            }
        }
        .padding([.leading, .bottom], 20)

    }
}

#Preview {
    favoriteCardView()
}


