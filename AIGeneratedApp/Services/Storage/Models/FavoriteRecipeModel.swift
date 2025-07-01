import Foundation
import SwiftData

@Model
final class FavoriteRecipeModel {
    @Attribute(.unique) var id: String
    var name: String
    var thumbnail: String?
    var category: String?
    var area: String?
    var instructions: String?
    var tags: String?
    var youtube: String?
    var source: String?
    var ingredients: [String]
    var measures: [String]
    var dateAdded: Date

    init(
        id: String,
        name: String,
        thumbnail: String? = nil,
        category: String? = nil,
        area: String? = nil,
        instructions: String? = nil,
        tags: String? = nil,
        youtube: String? = nil,
        source: String? = nil,
        ingredients: [String] = [],
        measures: [String] = [],
        dateAdded: Date = .now
    ) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.category = category
        self.area = area
        self.instructions = instructions
        self.tags = tags
        self.youtube = youtube
        self.source = source
        self.ingredients = ingredients
        self.measures = measures
        self.dateAdded = dateAdded
    }
}
