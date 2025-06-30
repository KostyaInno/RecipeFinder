import Observation

enum RecipeScreen {
    case list
    case detail(recipeID: String)
}

@Observable
final class RecipeCoordinator {
    var currentScreen: RecipeScreen = .list

    func showDetail(for recipeID: String) {
        currentScreen = .detail(recipeID: recipeID)
    }

    func backToList() {
        currentScreen = .list
    }
} 