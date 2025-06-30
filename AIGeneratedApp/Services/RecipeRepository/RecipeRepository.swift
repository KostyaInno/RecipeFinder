import Foundation

protocol RecipeRepositoryProtocol {
    func fetchRecipes(search: String) async throws -> [Recipe]
    func fetchRecipeDetail(id: String) async throws -> RecipeDetail?
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
        return response.meals ?? []
    }
    
    func fetchRecipeDetail(id: String) async throws -> RecipeDetail? {
        let response: RecipeDetailResponse = try await apiManager.request(
            RecipeRoute.mealDetail(id: id)
        )
        return response.meals?.first
    }
} 
