import Foundation
import UIKit

final class RatesConverterConfigurator {

    static func createMoviesDetailModule(with rates: Valute
    ) -> RatesConverterViewController {
        
        let view = RatesConverterViewController()
        let presenter = RatesConverterPresenter(with: rates)
        
        presenter.view = view
        view.presenter = presenter

        return view
    }
}
