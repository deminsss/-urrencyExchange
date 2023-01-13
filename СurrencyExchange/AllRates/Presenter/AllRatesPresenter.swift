import Foundation
import UIKit

protocol AllRatedPresenterProtocol: AnyObject {
    func fetchRated(with date: String)
    func numberOfItems(in section: Int) -> Int
    func namesOfItems(for indexPath: Int) -> NSAttributedString?
    func valuesOfItems(for indexPath: Int) -> NSAttributedString?
    func selectedRates(for indexPath: Int) -> Valute?
    func showRatesConverter(with rates: Valute)
}

final class AllRatesPresenter: AllRatedPresenterProtocol {
    
    weak var view: AllRatesViewProtocol!
    var network: AllRatesNetworkFacadeProtocol!
    var router: AllRatesRouterProtocol!
    private var allRates: ValCurs?
    private let moduleTitle = "Валюты"

    func fetchRated(with date: String) {
        
        view.setTitle(with: moduleTitle)
        Task {
            allRates = await network.fetchRates(with: date)
            await view.fetchRates()
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
        return allRates?.Valute.count ?? 0
    }
    
    func namesOfItems(for indexPath: Int) -> NSAttributedString? {
        
        guard let namesOfItem = allRates?.Valute[indexPath].CharCode else {
            return NSAttributedString(string: "")
        }
        let attributedString = NSAttributedString(
            string: namesOfItem,
            attributes: [.foregroundColor: UIColor.customBlue,
                         .font: UIFont(name: "SFProDisplay-Bold",
                                       size: 30) ?? NSAttributedString()])
        return attributedString
    }
    
    func valuesOfItems(for indexPath: Int) -> NSAttributedString? {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        
        guard let value = Double((
            allRates?.Valute[indexPath].Value.replacingOccurrences(
                of: ",", with: ".") ?? "")) else {
            return NSAttributedString()
        }
        
        let formattedString = formatter.string(from: value as NSNumber)
        guard let formattedString = formattedString else {
            return NSAttributedString(string: "")
        }
        
        let attributedString = NSAttributedString(
            string: formattedString.replacingOccurrences(of: ",", with: "."),
            attributes: [.foregroundColor: UIColor.customGray,
                         .font: UIFont(name: "SFProDisplay-Regular",
                                       size: 20) ?? NSAttributedString()])
        return attributedString
    }
    
    func selectedRates(for indexPath: Int) -> Valute? {
        return allRates?.Valute[indexPath]
    }
    
    func showRatesConverter(with rates: Valute) {
        router.showRatesConverter(with: rates)
    }
}
