import Foundation

struct RecipeListResponse: Decodable {
    let meals: [Recipe]?
} 