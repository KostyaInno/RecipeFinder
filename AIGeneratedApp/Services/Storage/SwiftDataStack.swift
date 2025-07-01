import SwiftData

protocol Configurable {
    var modelContainer: ModelContainer { get }
    var modelContext: ModelContext { get }
}

final class SwiftDataConfigurator: Configurable {
    lazy var modelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteRecipeModel.self
        ])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Cannot create model container - \(error)")
        }
    }()
    
    lazy var modelContext: ModelContext = {
        ModelContext(modelContainer)
    }()
}
