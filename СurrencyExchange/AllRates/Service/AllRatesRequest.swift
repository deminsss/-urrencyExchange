import Foundation

enum AllRatesRequest: RequestProtocol {

    case allRates(date: String)
    
    var path: String {
        switch self {
        case .allRates:
            return "/scripts/XML_daily.asp"
        }
    }
    var urlParams: [String: String?] {
        switch self {
        case .allRates(let date):
            return ["date_req": date]
        }
    }
    
    var requsetType: RequestType {
        switch self {
        case .allRates: return .GET
        }
    }
    
    


}
