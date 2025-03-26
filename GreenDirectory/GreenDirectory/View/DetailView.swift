//
//  DetailView.swift
//  GreenDirectory
//
//  Created by Marcelinus Gerardo on 25/03/25.
//  Edited by Thania Natasha

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
