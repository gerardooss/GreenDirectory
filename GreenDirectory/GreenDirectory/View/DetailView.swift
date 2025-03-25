//
//  DetailView.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//

import SwiftUI

struct DetailView: View {
    var tenantName: String
    
    var body: some View {
        VStack {
            Text(tenantName)
        }
        .navigationTitle(tenantName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(tenantName: "Item")
}
