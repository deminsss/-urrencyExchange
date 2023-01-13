import Foundation
import UIKit

enum NetworkError: LocalizedError {
    case invalidServerResponse
    case invalidURL
    case invalidDecode

    
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL string is malformed."
        case .invalidDecode:
            return "Failed decode"
        }
    }
}
