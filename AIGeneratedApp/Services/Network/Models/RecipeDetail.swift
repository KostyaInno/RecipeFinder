import Foundation

struct RecipeDetail: Decodable {
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
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case tags = "strTags"
        case youtube = "strYoutube"
        case source = "strSource"
    }
    
    // Custom decoding to handle ingredients and measures arrays
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtube = try container.decodeIfPresent(String.self, forKey: .youtube)
        source = try container.decodeIfPresent(String.self, forKey: .source)

        let rawContainer = try decoder.container(keyedBy: RawCodingKeys.self)
        var ingredientsArray: [String] = []
        var measuresArray: [String] = []
        for i in 1...20 {
            let ingredientKey = RawCodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = RawCodingKeys(stringValue: "strMeasure\(i)")!
            let ingredient = (try? rawContainer.decodeIfPresent(String.self, forKey: ingredientKey))?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let measure = (try? rawContainer.decodeIfPresent(String.self, forKey: measureKey))?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            if !ingredient.isEmpty {
                ingredientsArray.append(ingredient)
                measuresArray.append(measure)
            }
        }
        ingredients = ingredientsArray
        measures = measuresArray
    }

    struct RawCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }
        var intValue: Int? { nil }
        init?(intValue: Int) { nil }
    }
} 