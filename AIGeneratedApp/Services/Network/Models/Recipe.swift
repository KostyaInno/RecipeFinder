import Foundation

struct Recipe: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
} 