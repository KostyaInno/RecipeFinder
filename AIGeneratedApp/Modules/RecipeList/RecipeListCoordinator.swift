import SwiftUI
import Observation

enum RecipeListScreen {
    case list
    case detail(recipeID: String)
}

@Observable
final class RecipeListCoordinator {
    private let repository: RecipeRepositoryProtocol
    var currentScreen: RecipeListScreen = .list

    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }

    func showDetail(for recipeID: String) {
        currentScreen = .detail(recipeID: recipeID)
    }

    func backToList() {
        currentScreen = .list
    }

    func makeRecipeListView() -> some View {
        let viewModel = RecipeListViewModel(repository: repository)
        return RecipeListCoordinatorView(
            coordinator: self,
            viewModel: viewModel
        )
    }
}

struct RecipeListCoordinatorView: View {
    @Bindable var coordinator: RecipeListCoordinator
    @State var viewModel: RecipeListViewModel

    var body: some View {
        RecipeListView(
            viewModel: viewModel,
            onSelectRecipe: { id in coordinator.showDetail(for: id) }
        )
        .sheet(isPresented: .init(
            get: { if case .detail = coordinator.currentScreen { return true } else { return false } },
            set: { if !$0 { coordinator.backToList() } }
        )) {
            if case .detail(let id) = coordinator.currentScreen {
//                RecipeDetailView(recipeID: id)
            }
        }
    }
}
