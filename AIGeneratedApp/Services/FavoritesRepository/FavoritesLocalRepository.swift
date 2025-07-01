import Foundation

protocol FavoritesLocalRepositoryProtocol {
    func addOrUpdateFavorite(_ recipe: FavoriteRecipeModel) throws
    func removeFavorite(recipeId: String) throws
    func fetchFavorites() throws -> [FavoriteRecipeModel]
    func isFavorite(_ recipeId: String) throws -> Bool
}

final class FavoritesLocalRepository: FavoritesLocalRepositoryProtocol {
    private let storageManager: FavoritesStorageManaging
    
    init(storageManager: FavoritesStorageManaging) {
        self.storageManager = storageManager
    }
    
    func addOrUpdateFavorite(_ recipe: FavoriteRecipeModel) throws {
        try storageManager.addOrUpdateFavorite(recipe)
    }
    
    func removeFavorite(recipeId: String) throws {
        try storageManager.removeFavorite(recipeID: recipeId)
    }
    
    func fetchFavorites() throws -> [FavoriteRecipeModel] {
        try storageManager.fetchFavorites()
    }
    
    func isFavorite(_ recipeId: String) throws -> Bool {
        try storageManager.isFavorite(recipeId)
    }
} 
