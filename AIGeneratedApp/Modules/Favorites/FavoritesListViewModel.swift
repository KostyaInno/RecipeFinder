import Foundation
import Observation

@Observable
final class FavoritesListViewModel {
    var favorites: [Recipe] = []
    let favoritesRepository: FavoritesLocalRepositoryProtocol
    let recipeRepository: RecipeRepositoryProtocol
    
    init(
        favoritesRepository: FavoritesLocalRepositoryProtocol,
        recipeRepository: RecipeRepositoryProtocol
    ) {
        self.favoritesRepository = favoritesRepository
        self.recipeRepository = recipeRepository
        loadFavorites()
    }
    
    func loadFavorites() {
        do {
            let favoriteModels = try favoritesRepository.fetchFavorites()
            favorites = favoriteModels.map { RecipeMapper.from(model: $0) }
        } catch {
            favorites = []
        }
    }
    
    func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let recipe = favorites[index]
            do {
                try favoritesRepository.removeFavorite(recipeId: recipe.id)
            } catch {
                // Handle error if needed
            }
        }
        loadFavorites()
    }
} 
