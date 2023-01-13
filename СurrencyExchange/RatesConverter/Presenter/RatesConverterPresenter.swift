import Foundation
import UIKit

protocol RatesConverterPresenterProtocol: AnyObject {
    func valueOfCurrency() -> Double
    func charCodeOfCurrency() -> NSAttributedString
    func nameOfCurrency()-> NSAttributedString
    func attributesValueOfCurrency()-> NSAttributedString
    func setTitle()
}

final class RatesConverterPresenter: RatesConverterPresenterProtocol {
    
    weak var view: RatesConverterViewProtocol!
    var rates: Valute
    
    init(with rates: Valute) {
        self.rates = rates
    }
    
    func valueOfCurrency() -> Double {
        
        let value = rates.Value.replacingOccurrences(of: ",", with: ".")
        return Double(value) ?? 0
    }
    
    func charCodeOfCurrency() -> NSAttributedString {
        
        let attributedString = NSAttributedString(
            string: rates.CharCode,
            attributes: [.foregroundColor: UIColor.customGray,
                         .font: UIFont(name: "SFProText-Medium",
                                       size: 14) ?? NSAttributedString()])
        return attributedString
    }
    
    func nameOfCurrency() -> NSAttributedString {
        
        let attributedString = NSAttributedString(
            string: rates.Name,
            attributes: [.font: UIFont(name: "SFProDisplay-Regular",
                                       size: 18) ?? NSAttributedString()])
        return attributedString
    }
    
    func attributesValueOfCurrency() -> NSAttributedString {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        guard let value = Double(
            rates.Value.replacingOccurrences(of: ",", with: ".")) else {
            return NSAttributedString()
        }
        let formattedString = formatter.string(from: value as NSNumber)
        guard let formattedString = formattedString else {
            return NSAttributedString(string: "")
        }
        let attributedString = NSAttributedString(
            string: formattedString.replacingOccurrences(of: ",", with: "."),
            attributes: [.font: UIFont(name: "SFProText-Bold",
                                       size: 26) ?? NSAttributedString()])
        return attributedString
    }
    
    func setTitle() {
        let title = rates.CharCode
        view.setTitle(with: title)
    }
}
