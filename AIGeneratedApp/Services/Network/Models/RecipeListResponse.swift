import Foundation

struct RecipeListResponse: Decodable {
    let meals: [RecipeResponse]?
}
