import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var context
    @Query private var menusFromLocal: [Menu]
    @Query private var tenantsFromLocal: [Tenant]
    var menu: Menu
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var foodFilteredView: [Menu] {
        menusFromLocal .filter { ($0.ingredient == menu.ingredient
            || $0.category == menu.category) && $0.id != menu.id }
    }
    
    var selectedTenant: [Tenant] {
        tenantsFromLocal .filter { $0.id == menu.tenant?.id }
    }
    
    var body: some View {
        ScrollView {
            Image(menu.id)
                .resizable()
                .frame(width:370, height:270)
                .clipShape (RoundedRectangle(cornerRadius:15))
                .background(
                    RoundedRectangle(cornerRadius: 15).fill(Color.themeInverse.opacity(0.2))
                )
                .overlay(RoundedRectangle(cornerRadius:15).stroke(Color.themeInverse.opacity(0.2), lineWidth: 1))
                .padding(.horizontal, 15)
            
            VStack(alignment:.leading) {
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
                        .foregroundColor(.gray)
                        .italic()
                        .padding(.trailing, 8)
                    
                    Image(systemName: "carrot.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text(menu.ingredient)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .italic()
                        .padding(.trailing, 8)
                    
                    Image(systemName: "flask.fill")
                        .foregroundColor(.iconGreen)
                        .font(.system(size: 14))
                    Text(menu.taste)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
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
                        .overlay(Circle().stroke(Color.themeInverse.opacity(0.2), lineWidth: 1))
                    
                    Text(selectedTenant.first?.name ?? "Not found")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .padding(.top, 12)
            }
            .padding(.horizontal)
            
            Divider()
                .background(Color.themeInverse.opacity(0.2))
            
            HStack {
                Text("Similar food")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top, 12)
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, alignment: .leading) {
                ForEach(foodFilteredView) { menu in
                    NavigationLink(destination: DetailView(menu: menu)) {
                        MenuCardView(menu: menu)
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.theme)
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
    let sampleTenant = Tenant(id: "t1", name: "Sample Tenant", category: "Cafe", phone: "123456", desc: "Sample Desc")
    
    let sampleMenu = Menu(
        id: "m1",
        name: "Sample Menu",
        category: "Food",
        ingredient: "Ingredients",
        taste: "Sweet",
        price: 10.0,
        tenant: sampleTenant,
        isFavorite: false
    )
    
    DetailView(menu: sampleMenu)
}
