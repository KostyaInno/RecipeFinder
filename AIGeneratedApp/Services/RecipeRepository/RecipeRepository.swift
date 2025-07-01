import Foundation

enum RecipeRepositoryError: Error, LocalizedError {
    case noRecipeDetailFound
    var errorDescription: String? {
        switch self {
        case .noRecipeDetailFound:
            return "No recipe detail found."
        }
    }
}

protocol RecipeRepositoryProtocol {
    func fetchRecipes(search: String) async throws -> [Recipe]
    func fetchRecipeDetail(id: String) async throws -> RecipeDetail
}

final class RecipeRepository: RecipeRepositoryProtocol {
    private let apiManager: APIManaging

    init(apiManager: APIManaging = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchRecipes(search: String) async throws -> [Recipe] {
        let response: RecipeListResponse = try await apiManager.request(
            RecipeRoute.searchMeals(name: search)
        )
        return (response.meals ?? []).map { RecipeMapper.from(response: $0) }
    }
    
    func fetchRecipeDetail(id: String) async throws -> RecipeDetail {
        let response: RecipeDetailListResponse = try await apiManager.request(
            RecipeRoute.mealDetail(id: id)
        )
        guard let detail = response.meals?.first else {
            throw RecipeRepositoryError.noRecipeDetailFound
        }
        return RecipeDetailMapper.from(response: detail)
    }
} 
