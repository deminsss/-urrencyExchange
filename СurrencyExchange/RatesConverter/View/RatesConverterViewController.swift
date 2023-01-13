import UIKit

protocol RatesConverterViewProtocol: AnyObject {
    func setTitle(with title: String)
}

final class RatesConverterViewController: UIViewController {
    
    var presenter: RatesConverterPresenterProtocol!
    
    private var ratesView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBackground
        return view
    }()
    
    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = presenter.nameOfCurrency()
        return label
    }()
    
    private var rateLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSAttributedString(
            string: "Курс",
            attributes: [.foregroundColor: UIColor.customGray,
                         .font: UIFont(name: "SFProText-Medium",
                                       size: 14) ?? NSAttributedString()])
        label.attributedText = attributedString
        return label
    }()
    
    private lazy var valueLabel: UILabel  = {
        let label = UILabel()
        label.attributedText = presenter.attributesValueOfCurrency()
        return label
    }()
    
    private var convertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var firstCurrencyLabel: UILabel = {
        let label = UILabel()
        label.attributedText = presenter.charCodeOfCurrency()
        return label
    }()
    
    private lazy var firstCurrencyTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "0"
        textfield.font = UIFont(name: "SFProText-Medium",
                                size: 36)
        textfield.keyboardType = .decimalPad
        textfield.addTarget(self,
                            action: #selector(convertCurrency(_:)),
                            for: .editingChanged)
        return textfield
    }()
    
    private var secondCurrencyLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSAttributedString(
            string: "RUB",
            attributes: [.foregroundColor: UIColor.customGray,
                         .font: UIFont(name: "SFProText-Medium",
                                       size: 14) ?? NSAttributedString()])
        label.attributedText = attributedString
        return label
    }()
    
    private lazy var secondCurrencyTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "0"
        textfield.font = UIFont(name: "SFProText-Medium",
                                size: 36)
        textfield.keyboardType = .decimalPad
        textfield.addTarget(self,
                            action: #selector(convertRub(_:)),
                            for: .editingChanged)
        return textfield
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setTitle()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        view.addSubviews(ratesView, convertView)
        ratesView.addSubviews(currencyNameLabel, rateLabel, valueLabel)
        convertView.addSubviews(firstCurrencyLabel, firstCurrencyTextField,
                                secondCurrencyLabel, secondCurrencyTextField)
        navigationController?.navigationBar.titleTextAttributes =
        [.font: UIFont(name: "SFProText-Medium",
                       size: 17) ?? NSAttributedString()]
    }
    
    @objc func convertRub(_ textField: UITextField) {
        
        guard let inputString = secondCurrencyTextField.text,
                 !inputString.isEmpty else { return }
        let inputValue = Double(inputString) ?? 0
        let outputValue = inputValue * presenter.valueOfCurrency()
        firstCurrencyTextField.text = String(format: "%.2f", outputValue)
    }
    
    @objc func convertCurrency(_ textField: UITextField) {
        
        guard let inputString = firstCurrencyTextField.text,
                 !inputString.isEmpty else { return }
        let inputValue = Double(inputString) ?? 0
        let outputValue = inputValue * presenter.valueOfCurrency()
        secondCurrencyTextField.text = String(format: "%.2f", outputValue)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            ratesView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            ratesView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            ratesView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            ratesView.heightAnchor.constraint(equalToConstant: 120),
            
            currencyNameLabel.topAnchor.constraint(
                equalTo: ratesView.topAnchor, constant: 20),
            currencyNameLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            currencyNameLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16),

            rateLabel.topAnchor.constraint(
                equalTo: currencyNameLabel.bottomAnchor, constant: 6),
            rateLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),

            valueLabel.topAnchor.constraint(
                equalTo: rateLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),

            convertView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            convertView.topAnchor.constraint(
                equalTo: valueLabel.bottomAnchor, constant: 20),
            convertView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            convertView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),

            firstCurrencyLabel.topAnchor.constraint(
                equalTo: convertView.topAnchor, constant: 24),
            firstCurrencyLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),

            firstCurrencyTextField.topAnchor.constraint(
                equalTo: firstCurrencyLabel.bottomAnchor, constant: 8),
            firstCurrencyTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            firstCurrencyTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16),

            secondCurrencyLabel.topAnchor.constraint(
                equalTo: firstCurrencyTextField.bottomAnchor, constant: 20),
            secondCurrencyLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),

            secondCurrencyTextField.topAnchor.constraint(
                equalTo: secondCurrencyLabel.bottomAnchor, constant: 8),
            secondCurrencyTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            secondCurrencyTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension RatesConverterViewController: RatesConverterViewProtocol {
    
    func setTitle(with title: String) {
        self.title = title
    }
}
