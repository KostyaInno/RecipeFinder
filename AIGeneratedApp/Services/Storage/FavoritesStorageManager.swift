import Foundation
import SwiftData

protocol FavoritesStorageManaging {
    func addOrUpdateFavorite(_ recipe: FavoriteRecipeModel) throws
    func removeFavorite(recipeID: String) throws
    func fetchFavorites() throws -> [FavoriteRecipeModel]
    func isFavorite(_ recipeID: String) throws -> Bool
}

final class FavoritesStorageManager: FavoritesStorageManaging {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func addOrUpdateFavorite(_ recipe: FavoriteRecipeModel) throws {
        let id = recipe.id
        let descriptor = FetchDescriptor<FavoriteRecipeModel>(
            predicate: #Predicate { $0.id == id }
        )
        let results = try context.fetch(descriptor)
        if let existing = results.first {
            existing.name = recipe.name
            existing.thumbnail = recipe.thumbnail
            existing.category = recipe.category
            existing.area = recipe.area
            existing.instructions = recipe.instructions
            existing.tags = recipe.tags
            existing.youtube = recipe.youtube
            existing.source = recipe.source
            existing.ingredients = recipe.ingredients
            existing.measures = recipe.measures
            existing.dateAdded = recipe.dateAdded
        } else {
            context.insert(recipe)
        }
        try context.save()
    }

    func removeFavorite(recipeID: String) throws {
        let descriptor = FetchDescriptor<FavoriteRecipeModel>(predicate: #Predicate { $0.id == recipeID })
        let results = try context.fetch(descriptor)
        for recipe in results {
            context.delete(recipe)
        }
        try context.save()
    }
    
    func fetchFavorites() throws -> [FavoriteRecipeModel] {
        let descriptor = FetchDescriptor<FavoriteRecipeModel>(
            sortBy: [SortDescriptor(\FavoriteRecipeModel.dateAdded, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
    
    func isFavorite(_ recipeID: String) throws -> Bool {
        let descriptor = FetchDescriptor<FavoriteRecipeModel>(
            predicate: #Predicate { $0.id == recipeID }
        )
        let results = try context.fetch(descriptor)
        return !results.isEmpty
    }
} 
