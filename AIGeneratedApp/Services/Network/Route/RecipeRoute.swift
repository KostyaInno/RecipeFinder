import Foundation

enum RecipeRoute: APIRoute {
    case searchMeals(name: String)
    case mealDetail(id: String)
    case randomMeal
    case categories

    var baseURL: String { "https://www.themealdb.com/api/json/v1/1" }

    var path: String {
        switch self {
        case .searchMeals: return "/search.php"
        case .mealDetail: return "/lookup.php"
        case .randomMeal: return "/random.php"
        case .categories: return "/categories.php"
        }
    }

    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchMeals(let name):
            return [URLQueryItem(name: "s", value: name)]
        case .mealDetail(let id):
            return [URLQueryItem(name: "i", value: id)]
        case .randomMeal, .categories:
            return nil
        }
    }
} 