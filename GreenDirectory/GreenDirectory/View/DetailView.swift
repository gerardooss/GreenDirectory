import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var context
    var menu: Menu

    var body: some View {
        VStack {
            Text(menu.name)
                .font(.title)

            Spacer()

            Button {
                toggleFavorite()
            } label: {
                Image(systemName: menu.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.largeTitle)
            }
        }
        .padding()
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



