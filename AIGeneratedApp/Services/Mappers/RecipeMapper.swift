import Foundation

enum RecipeMapper {
    static func from(response: RecipeResponse) -> Recipe {
        Recipe(
            id: response.id,
            name: response.name,
            thumbnail: response.thumbnail
        )
    }
    
    static func from(model: FavoriteRecipeModel) -> Recipe {
        Recipe(
            id: model.id,
            name: model.name,
            thumbnail: model.thumbnail
        )
    }

    static func toFavorite(_ recipe: Recipe) -> FavoriteRecipeModel {
        FavoriteRecipeModel(
            id: recipe.id,
            name: recipe.name,
            thumbnail: recipe.thumbnail
        )
    }
} 
