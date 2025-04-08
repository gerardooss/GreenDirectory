
//  MenuView.swift
//  GreenDirectory
//
//  Created by Georgius Kenny Gunawan on 26/03/25.
//

import SwiftUI
import SwiftData
import SwiftUIFlow
import UIKit
import WARangeSlider

struct MenuView: View {
    @Environment(\.modelContext) private var context
    @Query private var menusFromLocal: [Menu]
    @State var searchText: String = ""
    @State var isModalOpen: Bool = false
    
    @State private var selectedCategories: Set<String> = []
    @State private var selectedIngredients: Set<String> = []
    @State private var selectedTastes: Set<String> = []
    
    @State private var minPrice: Double = 0
    @State private var maxPrice: Double = 50000
    
    var selectedPriceRange: ClosedRange<Double> {
        minPrice...maxPrice
    }
    
    var tenantId: String
    var tenantName: String
    var tenantContact: String
    var tenantDesc: String
    
    var foodFilteredView: [Menu] {
        menusFromLocal
            .filter { $0.tenant?.id == tenantId }
            .filter { menu in
                let matchesSearch = searchText.isEmpty || menu.name.lowercased().contains(searchText.lowercased())
                let matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(menu.category)
                let matchesIngredient = selectedIngredients.isEmpty || selectedIngredients.contains(menu.ingredient)
                let matchesTaste = selectedTastes.isEmpty || selectedTastes.contains(menu.taste)
                let matchesPrice = Double(menu.price) >= minPrice && Double(menu.price) <= maxPrice
                
                return matchesSearch && matchesCategory && matchesIngredient && matchesTaste && matchesPrice
            }
    }
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Image(tenantId)
                            .resizable()
                            .frame(width: 130, height: 130)
                            .scaledToFill()
                            .clipShape(.circle)
                            .overlay(
                                Circle().stroke(
                                    Color.black.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.leading, 20)
                            .padding(.vertical, 8)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 6) {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(Color.iconGreen)
                                
                                Text(tenantContact)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.gray)
                                    .padding(.bottom, 1)
                            }
                            Text(tenantDesc)
                                .font(.system(size: 12))
                                .lineLimit(4)
                        }
                        .padding(.leading, 4)
                        
                        Spacer()
                    }
                    .padding(.trailing, 4)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.black.opacity(0.3))
                    
                    // Menu list
                    LazyVGrid(columns: columns, alignment: .leading) {
                        ForEach(foodFilteredView) { menu in
                            NavigationLink(destination: DetailView(menu: menu)) {
                                MenuCardView(menu: menu)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                }
                .navigationTitle(Text(tenantName))
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.isModalOpen = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .sheet(isPresented: $isModalOpen) { filterModal() }
                    
                }
            }
        }
        
        .tint(Color.iconGreen)
    }
    
    private func filterModal() -> some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 40, height: 5)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 8)
                .frame(maxWidth: .infinity)
            
            Text("Filters")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top, 6)
                .frame(maxWidth: .infinity)
            
            Group {
                FilterButton(
                    segmentTitle: "Category",
                    itemTitle: ["Main dish", "Side dish", "Snack", "Dessert", "Drink", "Other"],
                    selectedItems: $selectedCategories
                )
                
                FilterButton(
                    segmentTitle: "Main Ingredients",
                    itemTitle: ["Chicken", "Beef", "Fish", "Shrimp", "Egg", "Rice", "Noodles", "Veggies", "Other"],
                    selectedItems: $selectedIngredients
                )
                
                FilterButton(
                    segmentTitle: "Taste",
                    itemTitle: ["Sweet", "Savoury", "Spicy", "Other"],
                    selectedItems: $selectedTastes
                )
                
                VStack(alignment: .leading) {
                    Text("Price")
                        .font(.headline)
                        .padding(.top, 6)
                    
                    HStack {
                        Text("Min: Rp\(currencyFormat(minPrice))")
                        Spacer()
                        Text("Max: Rp\(currencyFormat(maxPrice))")
                    }
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    
                    RangeSliderView(
                        lowerValue: $minPrice,
                        upperValue: $maxPrice,
                        minimumValue: 0,
                        maximumValue: 50_000
                    )
                    .frame(height: 40)
                }
                .padding(.top, 6)
            }
            .padding(.top, 12)
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button("Reset") {
                    selectedCategories.removeAll()
                    selectedIngredients.removeAll()
                    selectedTastes.removeAll()
                    minPrice = 0
                    maxPrice = 50000
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.red)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.red, lineWidth: 3)
                )
                .cornerRadius(8)
                
                Button("Apply") { isModalOpen = false }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.iconGreen)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .background(Color.gray.opacity(0.05))
    }
    
    // Chip component
    struct FilterButton: View {
        var segmentTitle: String
        var itemTitle: [String]
        @Binding var selectedItems: Set<String>
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(segmentTitle)
                    .font(.headline)
                    .padding(.top, 6)
                
                Flow(.vertical, alignment: .topLeading, spacing: 8) {
                    ForEach(itemTitle, id: \.self) { item in
                        Text(item)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(
                                selectedItems.contains(item) ? Color.iconGreen : Color.gray.opacity(0.2)
                            )
                            .foregroundColor(selectedItems.contains(item) ? .white : .primary)
                            .cornerRadius(10)
                            .onTapGesture {
                                if selectedItems.contains(item) {
                                    selectedItems.remove(item)
                                } else {
                                    selectedItems.insert(item)
                                }
                            }
                    }
                }
            }
        }
    }
    
    // Double slider component
    struct RangeSliderView: UIViewRepresentable {
        @Binding var lowerValue: Double
        @Binding var upperValue: Double
        var minimumValue: Double
        var maximumValue: Double
        
        func makeUIView(context: Context) -> RangeSlider {
            let rangeSlider = RangeSlider(frame: .zero)
            rangeSlider.minimumValue = minimumValue
            rangeSlider.maximumValue = maximumValue
            rangeSlider.lowerValue = lowerValue
            rangeSlider.upperValue = upperValue
            
            rangeSlider.trackTintColor = UIColor.lightGray
            rangeSlider.trackHighlightTintColor = UIColor(named: "IconGreen") ?? .systemGreen
            
            rangeSlider.addTarget(
                context.coordinator,
                action: #selector(Coordinator.rangeSliderValueChanged(_:)),
                for: .valueChanged
            )
            return rangeSlider
        }
        
        
        func updateUIView(_ uiView: RangeSlider, context: Context) {
            uiView.lowerValue = lowerValue
            uiView.upperValue = upperValue
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject {
            var parent: RangeSliderView
            
            init(_ parent: RangeSliderView) {
                self.parent = parent
            }
            
            @objc func rangeSliderValueChanged(_ sender: RangeSlider) {
                parent.lowerValue = round(sender.lowerValue / 1000) * 1000
                parent.upperValue = round(sender.upperValue / 1000) * 1000
            }
        }
    }
    
    func currencyFormat(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value: Int(value))) ?? "\(Int(value))"
    }
}

#Preview {
    MenuView(tenantId: "t1",
             tenantName: "Ahza Snack & Beverages",
             tenantContact:"12341412",
             tenantDesc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed pellentesque justo.")
}
