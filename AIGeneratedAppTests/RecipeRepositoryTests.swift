import XCTest
@testable import AIGeneratedApp

final class AIGeneratedAppTests: XCTestCase {
    func testFetchRecipesSuccess() async throws {
        let mockAPI = MockAPIManager()
        let expected = [RecipeResponse(id: "1", name: "Test", thumbnail: nil)]
        mockAPI.stubbedResponse = RecipeListResponse(meals: expected)
        let repo = RecipeRepository(apiManager: mockAPI)
        let recipes = try await repo.fetchRecipes(search: "Test")
        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.id, "1")
    }
    
    func testFetchRecipesError() async {
        let mockAPI = MockAPIManager()
        mockAPI.stubbedError = URLError(.badServerResponse)
        let repo = RecipeRepository(apiManager: mockAPI)
        do {
            _ = try await repo.fetchRecipes(search: "Test")
            XCTFail("Expected error")
        } catch {
            // Success
        }
    }
    
    func testFetchRecipeDetailSuccess() async throws {
        let mockAPI = MockAPIManager()
        let expected = [RecipeDetailResponse(id: "1", name: "Test", category: nil, area: nil, instructions: nil, thumbnail: nil, tags: nil, youtube: nil, source: nil, ingredients: [], measures: [])]
        mockAPI.stubbedResponse = RecipeDetailListResponse(meals: expected)
        let repo = RecipeRepository(apiManager: mockAPI)
        let detail = try await repo.fetchRecipeDetail(id: "1")
        XCTAssertEqual(detail.id, "1")
    }
    
    func testFetchRecipeDetailError() async {
        let mockAPI = MockAPIManager()
        mockAPI.stubbedError = URLError(.badServerResponse)
        let repo = RecipeRepository(apiManager: mockAPI)
        do {
            _ = try await repo.fetchRecipeDetail(id: "1")
            XCTFail("Expected error")
        } catch {
            // Success
        }
    }
} 