import SwiftUI
import Observation

enum RecipeListScreen {
    case list
    case detail(recipeID: String)
}

@Observable
final class RecipeListCoordinator {
    private let recipeRepository: RecipeRepositoryProtocol
    private let favoritesRepository: FavoritesLocalRepositoryProtocol
    var currentScreen: RecipeListScreen = .list

    init(recipeRepository: RecipeRepositoryProtocol, favoritesRepository: FavoritesLocalRepositoryProtocol) {
        self.recipeRepository = recipeRepository
        self.favoritesRepository = favoritesRepository
    }

    func showDetail(for recipeID: String) {
        currentScreen = .detail(recipeID: recipeID)
    }

    func backToList() {
        currentScreen = .list
    }

    func makeRecipeListView() -> some View {
        let viewModel = RecipeListViewModel(recipeRepository: recipeRepository, favoritesRepository: favoritesRepository)
        return RecipeListCoordinatorView(
            coordinator: self,
            viewModel: viewModel,
            repository: recipeRepository,
            favoritesRepository: favoritesRepository
        )
    }
}

struct RecipeListCoordinatorView: View {
    @Bindable var coordinator: RecipeListCoordinator
    @State var viewModel: RecipeListViewModel
    let repository: RecipeRepositoryProtocol
    let favoritesRepository: FavoritesLocalRepositoryProtocol

    var body: some View {
        RecipeListView(
            viewModel: viewModel,
            onSelectRecipe: { id in
                coordinator.showDetail(for: id)
            }
        )
        .sheet(isPresented: .init(
            get: { if case .detail = coordinator.currentScreen { true } else { false } },
            set: { isPresented in
                if !isPresented {
                    coordinator.backToList()
                    viewModel.reloadFavorites()
                }
            }
        )) {
            if case .detail(let id) = coordinator.currentScreen {
                RecipeDetailView(
                    viewModel: RecipeDetailViewModel(
                        repository: repository,
                        favoritesRepository: favoritesRepository,
                        recipeId: id
                    )
                )
            }
        }
    }
}
