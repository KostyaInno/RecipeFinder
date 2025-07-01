import Testing
import Foundation
@testable import AIGeneratedApp

struct RecipeRepositoryTests {
    var mockAPI = MockAPIManager()
    var sut: RecipeRepository { RecipeRepository(apiManager: mockAPI) }

    @Test
    func testFetchRecipesSuccess() async throws {
        let expected = [RecipeResponse(id: "1", name: "Test", thumbnail: nil)]
        mockAPI.stubbedResponse = RecipeListResponse(meals: expected)
        let recipes = try await sut.fetchRecipes(search: "Test")
        #expect(recipes.count == 1)
        #expect(recipes.first?.id == "1")
    }

    @Test
    func testFetchRecipesError() async {
        mockAPI.stubbedError = URLError(.badServerResponse)
        do {
            _ = try await sut.fetchRecipes(search: "Test")
            #expect(Bool(false), "Expected error")
        } catch {
            #expect(true)
        }
    }

    @Test
    func testFetchRecipeDetailError() async {
        mockAPI.stubbedError = URLError(.badServerResponse)
        do {
            _ = try await sut.fetchRecipeDetail(id: "1")
            #expect(Bool(false), "Expected error")
        } catch {
            #expect(true)
        }
    }
}
