import Foundation

protocol RequestProtocol  {
    var path: String { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var requsetType: RequestType { get }
    var urlParams: [String: String?] { get}
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }

    var params: [String: Any] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                return URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = components.url
        else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requsetType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(
                withJSONObject: params)
        }
        
        return urlRequest
    }
}
