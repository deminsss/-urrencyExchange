import UIKit

final class AllRatesConfigurator {
    
    static func createAllRatesModule(
        with navigationConroller: UINavigationController
    ) -> UIViewController {
        
        let view = AllRatesViewController()
        let presenter = AllRatesPresenter()
        let network = AllRatesNetworkFacade()
        let router = AllRatesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.network = network
        presenter.router = router
        router.presenter = presenter
        router.navigationConroller = navigationConroller
        
        return view
    }
}
