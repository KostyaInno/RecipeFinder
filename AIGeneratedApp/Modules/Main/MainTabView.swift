import SwiftUI

struct MainTabView: View {
    let coordinator: MainTabCoordinator
    var body: some View {
        TabView {
            coordinator.makeRecipeListTab()
                .tabItem {
                    Label(Strings.recipeListTitle, systemImage: "list.bullet")
                }
            coordinator.makeFavoritesTab()
                .tabItem {
                    Label(Strings.favoritesTabTitle, systemImage: "heart")
                }
            coordinator.makeProfileTab()
                .tabItem {
                    Label(Strings.profileTabTitle, systemImage: "person")
                }
        }
    }
} 