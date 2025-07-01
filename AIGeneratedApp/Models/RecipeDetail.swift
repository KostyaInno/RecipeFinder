import Foundation

struct RecipeDetail: Identifiable {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnail: String?
    let tags: String?
    let youtube: String?
    let source: String?
    let ingredients: [String]
    let measures: [String]
} 
