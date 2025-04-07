import SwiftUI
import _SwiftData_SwiftUI

struct FavoriteView: View {
    @State var searchText:String = ""
    @Query(filter: #Predicate<Menu> { $0.isFavorite == true }) private var favoriteMenus: [Menu]

    var groupedFavorites: [Tenant: [Menu]] {
        Dictionary(grouping: favoriteMenus) { $0.tenant! }
    }

    
    var filteredFavorites: [Tenant: [Menu]] {
        let filtered = favoriteMenus.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
        return Dictionary(grouping: filtered) { $0.tenant! }
    }

    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(filteredFavorites.keys.sorted(by: { $0.name < $1.name }), id: \.id) { tenant in
                    if let menus = filteredFavorites[tenant] {
                        VStack(alignment: .leading) {
                            Text(tenant.name)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(menus) { menu in
                                        MenuCardView(menu: menu)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }

            }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) )
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Filter Menu")
        }
    }
}

#Preview {
    FavoriteView()
}
