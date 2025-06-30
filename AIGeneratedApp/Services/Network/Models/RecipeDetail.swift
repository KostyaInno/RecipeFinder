import Foundation

struct RecipeDetail: Decodable {
    let id: String
    let name: String
    let instructions: String?
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
    }
} 