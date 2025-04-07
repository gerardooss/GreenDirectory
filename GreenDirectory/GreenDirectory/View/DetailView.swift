import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var context
    @Query private var menusFromLocal: [Menu]
    var menu: Menu
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var foodFilteredView: [Menu] {
        menusFromLocal .filter { $0.tenant?.id == menu.tenant?.id }
    }
    
    var body: some View {
        VStack {
            Image("")
                .resizable()
                .frame(width:370, height:270)
                .clipShape (RoundedRectangle(cornerRadius:15))
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(Color.themeInverse.opacity(0.2))
                )
                .padding(.horizontal, 15)
            
            VStack(alignment:.leading, spacing: 6) {
                HStack {
                    Text("Ayam Goreng Madu")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundStyle(.themeInverse)
                    
                    Spacer()
                    
                    Text("Rp 12.000")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }
                
                HStack(spacing: 2) {
                    Image(systemName: "tag.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text("Side Dish")
                        .font(.system(size: 15))
                        .italic()
                        .padding(.trailing, 8)
                    
                    Image(systemName: "carrot.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text("Ayam")
                        .font(.system(size: 15))
                        .italic()
                        .padding(.trailing, 8)
                    
                    Image(systemName: "flask.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text("Manis")
                        .font(.system(size: 15))
                        .italic()
                    
                    Spacer()
                    
                    Button {
                        toggleFavorite()
                    } label: {
                        Image(systemName: menu.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.system(size: 24))
                    }
                }
                
                HStack {
                    Image("")
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(.themeInverse))
                    
                    Text("Kasturi")
                        .font(.title3)
                        .fontWeight(.medium)
                }
                .padding(.top, 12)
            }
            .padding(.horizontal)
            
            Divider()
                .frame(height: 1)
                .background(Color.themeInverse.opacity(0.5))
            
            ScrollView {
                HStack {
                    Text("Another Food by Kasturi")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top, 8)
                .padding(.horizontal)
                
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
            
            Spacer()
        }
    }
    
    private func toggleFavorite() {
        menu.isFavorite.toggle()
        do {
            try context.save()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}




#Preview {
    let sampleTenant = Tenant(id: "t1", name: "Sample Tenant", category: "Cafe", phone: "123456")
    
    let sampleMenu = Menu(
        id: "m1",
        name: "Sample Menu",
        category: "Food",
        ingredient: "Ingredients",
        taste: "Sweet",
        price: 10.0,
        tenant: sampleTenant,
        isFavorite: false,
        skw: ""
    )
    
    return DetailView(menu: sampleMenu)
}
