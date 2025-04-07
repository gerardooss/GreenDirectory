import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var context
    @Query private var menusFromLocal: [Menu]
    @Query private var tenantsFromLocal: [Tenant]
    var menu: Menu
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var foodFilteredView: [Menu] {
        menusFromLocal .filter { $0.tenant?.id == menu.tenant?.id }
    }
    
    var selectedTenant: [Tenant] {
        tenantsFromLocal .filter { $0.id == menu.tenant?.id }
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
                    Text(menu.name)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundStyle(.themeInverse)
                    
                    Spacer()
                    
                    Text("Rp \(Int(menu.price))")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }
                
                HStack(spacing: 2) {
                    Image(systemName: "tag.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text(menu.category)
                        .font(.system(size: 15))
                        .italic()
                        .padding(.trailing, 8)
                    
                    Image(systemName: "carrot.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text(menu.ingredient)
                        .font(.system(size: 15))
                        .italic()
                        .padding(.trailing, 8)
                    
                    Image(systemName: "flask.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text(menu.taste)
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
                    Image(selectedTenant.first?.id ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(Color.theme))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .padding(.trailing, 6)
                    
                    Text(selectedTenant.first?.name ?? "Not found")
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
                    Text("Another Food by \(String(selectedTenant.first?.name ?? "Not found"))")
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
