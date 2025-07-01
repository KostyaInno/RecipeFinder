import SwiftUI

final class MainTabCoordinator {
    let dependencies: AppDependencies
    let onLogout: () -> Void

    init(dependencies: AppDependencies, onLogout: @escaping () -> Void) {
        self.dependencies = dependencies
        self.onLogout = onLogout
    }

    func makeRecipeListTab() -> some View {
        RecipeListCoordinator(repository: dependencies.recipeRepository).makeRecipeListView()
    }

    func makeFavoritesTab() -> some View {
        FavoritesView()
    }

    func makeProfileTab() -> some View {
        let viewModel = ProfileViewModel(
            credentialsManager: dependencies.credentialsManager,
            authManager: dependencies.authManager,
            onLogout: onLogout
        )
        return ProfileView(viewModel: viewModel)
    }
} 