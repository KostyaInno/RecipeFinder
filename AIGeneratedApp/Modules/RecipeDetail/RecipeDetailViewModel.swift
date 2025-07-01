import Foundation
import Observation

@Observable
final class RecipeDetailViewModel {
    var recipe: RecipeDetail?
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var isFavorite: Bool = false
    
    private let repository: RecipeRepositoryProtocol
    private let favoritesRepository: FavoritesLocalRepositoryProtocol
    private let recipeId: String
    
    init(repository: RecipeRepositoryProtocol, favoritesRepository: FavoritesLocalRepositoryProtocol, recipeId: String) {
        self.repository = repository
        self.favoritesRepository = favoritesRepository
        self.recipeId = recipeId
    }
    
    @MainActor
    func fetchRecipeDetail() async {
        isLoading = true
        errorMessage = nil
        do {
            let detail = try await repository.fetchRecipeDetail(id: recipeId)
            recipe = detail
            isFavorite = checkIsFavorite()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func toggleFavorite() {
        guard let recipe else { return }
        if isFavorite {
            removeFavorite(recipe)
        } else {
            addFavorite(recipe)
        }
        isFavorite.toggle()
    }
    
    private func checkIsFavorite() -> Bool {
        do {
            return try favoritesRepository.isFavorite(recipeId)
        } catch {
            return false
        }
    }
    
    private func addFavorite(_ recipe: RecipeDetail) {
        do {
            let favorite = RecipeDetailMapper.toFavorite(recipe)
            try favoritesRepository.addOrUpdateFavorite(favorite)
        } catch {
            // Handle error if needed
        }
    }
    
    private func removeFavorite(_ recipe: RecipeDetail) {
        do {
            try favoritesRepository.removeFavorite(recipeId: recipe.id)
        } catch {
            // Handle error if needed
        }
    }
} 
