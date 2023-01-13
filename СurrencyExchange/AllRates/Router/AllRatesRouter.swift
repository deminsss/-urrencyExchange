import UIKit

protocol AllRatesRouterProtocol {
    func showRatesConverter(with rates: Valute)
}

final class AllRatesRouter: AllRatesRouterProtocol {

    weak var presenter: AllRatedPresenterProtocol!
    var navigationConroller: UINavigationController!
    
    func showRatesConverter(with rates: Valute) {
        
        let ratesConverter =
        RatesConverterConfigurator.createMoviesDetailModule(with: rates)
        self.navigationConroller.pushViewController(
            ratesConverter, animated: true)
    }
}
