import Foundation

protocol AllRatesNetworkFacadeProtocol: AnyObject {
    func fetchRates(with date: String) async -> ValCurs?
}

final class AllRatesNetworkFacade: AllRatesNetworkFacadeProtocol {
    
    private let requestManager = RequestManager()
    
    func fetchRates(with date: String) async -> ValCurs? {
        
        let requestData = AllRatesRequest.allRates(date: date)
        do {
            let AllRates: ValCurs = try await
            requestManager.perform(requestData)
            return AllRates
        } catch {
            return nil
        }
        
        
    }
}
