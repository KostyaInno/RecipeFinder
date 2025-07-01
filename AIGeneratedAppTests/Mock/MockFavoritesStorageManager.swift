final class MockFavoritesStorageManager: FavoritesStorageManaging {
    var storage: [String: FavoriteRecipeModel] = [:]
    var addOrUpdateCalled = false
    var removeCalled = false
    
    func addOrUpdateFavorite(_ recipe: FavoriteRecipeModel) throws {
        storage[recipe.id] = recipe
        addOrUpdateCalled = true
    }
    
    func removeFavorite(recipeID: String) throws {
        storage.removeValue(forKey: recipeID)
        removeCalled = true
    }
    
    func fetchFavorites() throws -> [FavoriteRecipeModel] {
        Array(storage.values)
    }
    
    func isFavorite(_ recipeID: String) throws -> Bool {
        storage[recipeID] != nil
    }
}