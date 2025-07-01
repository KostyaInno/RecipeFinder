import Foundation

protocol APIManaging {
    func request<T: Decodable>(_ route: APIRoute) async throws -> T
}

final class APIManager: APIManaging {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(_ route: APIRoute) async throws -> T {
        guard let request = route.makeRequest() else { throw URLError(.badURL) }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try decoder.decode(T.self, from: data)
    }
} 
 