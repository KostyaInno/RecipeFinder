import Foundation
import Testing
@testable import AIGeneratedApp


struct FavoritesLocalRepositoryTests {
    var mockStorage = MockFavoritesStorageManager()
    var sut: FavoritesLocalRepository { FavoritesLocalRepository(storageManager: mockStorage) }

    @Test
    func testAddFavorite() throws {
        let favorite = FavoriteRecipeModel(id: "1", name: "Test")
        try sut.addOrUpdateFavorite(favorite)
        #expect(mockStorage.storage["1"]?.name == "Test")
        #expect(mockStorage.addOrUpdateCalled)
    }

    @Test
    func testRemoveFavorite() throws {
        let favorite = FavoriteRecipeModel(id: "1", name: "Test")
        mockStorage.storage["1"] = favorite
        try sut.removeFavorite(recipeId: "1")
        #expect(mockStorage.storage["1"] == nil)
        #expect(mockStorage.removeCalled)
    }

    @Test
    func testFetchFavorites() throws {
        let favorite = FavoriteRecipeModel(id: "1", name: "Test")
        mockStorage.storage["1"] = favorite
        let result = try sut.fetchFavorites()
        #expect(result.count == 1)
        #expect(result.first?.id == "1")
    }

    @Test
    func testIsFavorite() throws {
        let favorite = FavoriteRecipeModel(id: "1", name: "Test")
        mockStorage.storage["1"] = favorite

        #expect(try sut.isFavorite("1"))

        do {
            let result = try sut.isFavorite("2")
            #expect(!result)
        } catch {
            #expect(Bool(false), "Unexpected error: \\(error)")
        }
    }
}
