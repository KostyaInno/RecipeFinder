import Foundation

enum RecipeDetailMapper {
    static func from(response: RecipeDetailResponse) -> RecipeDetail {
        RecipeDetail(
            id: response.id,
            name: response.name,
            category: response.category,
            area: response.area,
            instructions: response.instructions,
            thumbnail: response.thumbnail,
            tags: response.tags,
            youtube: response.youtube,
            source: response.source,
            ingredients: response.ingredients,
            measures: response.measures
        )
    }
    
    static func from(model: FavoriteRecipeModel) -> RecipeDetail {
        RecipeDetail(
            id: model.id,
            name: model.name,
            category: model.category,
            area: model.area,
            instructions: model.instructions,
            thumbnail: model.thumbnail,
            tags: model.tags,
            youtube: model.youtube,
            source: model.source,
            ingredients: model.ingredients,
            measures: model.measures
        )
    }
    
    static func toFavorite(_ detail: RecipeDetail) -> FavoriteRecipeModel {
        FavoriteRecipeModel(
            id: detail.id,
            name: detail.name,
            thumbnail: detail.thumbnail,
            category: detail.category,
            area: detail.area,
            instructions: detail.instructions,
            tags: detail.tags,
            youtube: detail.youtube,
            source: detail.source,
            ingredients: detail.ingredients,
            measures: detail.measures
        )
    }
} 
