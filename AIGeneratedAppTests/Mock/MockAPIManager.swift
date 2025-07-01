import Foundation
@testable import AIGeneratedApp

final class MockAPIManager: APIManaging {
    var stubbedResponse: Any?
    var stubbedError: Error?
    
    func request<T>(_ route: APIRoute) async throws -> T where T : Decodable {
        if let error = stubbedError {
            throw error
        }
        if let response = stubbedResponse as? T {
            return response
        }
        fatalError("No stubbed response set for type \(T.self)")
    }
} 
