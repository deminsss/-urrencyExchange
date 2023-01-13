import Foundation

protocol APIManagerProtocol {
    func perform(_ urlRequest: RequestProtocol) async throws -> Data
}

final class APIManager: APIManagerProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(_ urlRequest: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(
            for: urlRequest.createURLRequest())
        guard let httpResonse = response as? HTTPURLResponse,
              httpResonse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}
