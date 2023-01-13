import UIKit

protocol AllRatesViewProtocol: AnyObject {
    func fetchRates() async
    func setTitle(with title: String)
}

final class AllRatesViewController: UIViewController {

    var presenter: AllRatedPresenterProtocol!
    
    private lazy var dateTextField: UITextField = {
        let dateTextField = UITextField()
        dateTextField.borderStyle = .roundedRect
        dateTextField.rightView = containterView
        dateTextField.rightViewMode = .always
        dateTextField.text = formatingDateToUI(with: Date())
        let attributedString = NSAttributedString(
            string: dateTextField.text!,
            attributes: [.font: UIFont(name: "SFProText-Medium",
                                       size: 18) ?? NSAttributedString()])
        dateTextField.attributedText = attributedString
        return dateTextField
    }()
    
    private lazy var containterView: UIView = {
        let containerView = UIView()
        containerView.addSubviews(imageView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icons Left")
        return imageView
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private lazy var dateChooserAlert: UIAlertController = {
        let dateChooserAlert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        dateChooserAlert.addAction(
            UIAlertAction(title: "Сохранить",
                          style: .default,
                          handler: { [self] action in
            dateTextField.text = formatingDateToUI(with: datePicker.date)
            let date = formatingDateToService(with: datePicker.date)
            presenter.fetchRated(with: date)
        }))
        
        dateChooserAlert.addAction(
            UIAlertAction(title: "Отмена",
                          style: .cancel))
        
        dateChooserAlert.view.addSubviews(datePicker)
        return dateChooserAlert
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(
                AllRatesCollectionViewCell.self,
            forCellWithReuseIdentifier:
                AllRatesCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        setupView()
        makeConstraints()
        makeAndSetLayout()
        let date = formatingDateToService(with: datePicker.date)
        presenter.fetchRated(with: date)
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubviews(dateTextField, collectionView)
        dateTextField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }
    
    private func makeAndSetLayout() {
        let spacing: CGFloat = 4
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.33),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing,
                                   leading: spacing,
                                   bottom: spacing,
                                   trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }
    
    private func formatingDateToService(with date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    private func formatingDateToUI(with date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: date)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
        dateTextField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
        dateTextField.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 24),
        dateTextField.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -24),

        containterView.heightAnchor.constraint(
            equalToConstant: 44),
        containterView.widthAnchor.constraint(
            equalToConstant: 48),
        
        imageView.heightAnchor.constraint(
            equalToConstant: 24),
        imageView.widthAnchor.constraint(
            equalToConstant: 24),
        imageView.centerXAnchor.constraint(
            equalTo: containterView.centerXAnchor),
        imageView.centerYAnchor.constraint(
            equalTo: containterView.centerYAnchor),
        
        dateChooserAlert.view.heightAnchor.constraint(
            equalToConstant: 310),
        datePicker.centerXAnchor.constraint(
            equalTo: dateChooserAlert.view.centerXAnchor),
        datePicker.topAnchor.constraint(
            equalTo: dateChooserAlert.view.topAnchor),
        
        collectionView.topAnchor.constraint(
            equalTo: dateTextField.bottomAnchor, constant: 16),
        collectionView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        collectionView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 20),
        collectionView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

extension AllRatesViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        dateTextField.resignFirstResponder()
        self.present(dateChooserAlert, animated: true, completion: nil)
    }
}

extension AllRatesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int
    ) -> Int {
        presenter.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AllRatesCollectionViewCell.identifier,
            for: indexPath) as? AllRatesCollectionViewCell else {
                return UICollectionViewCell()
            }
        
        cell.nameLabel.attributedText = presenter.namesOfItems(
            for: indexPath.row)
        cell.valueLabel.attributedText = presenter.valuesOfItems(
            for: indexPath.row)
        cell.layer.cornerRadius = 12
        cell.backgroundColor = UIColor.customBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedRates = presenter.selectedRates(
            for: indexPath.row) else { return }
        presenter.showRatesConverter(with: selectedRates)
    }

}

extension AllRatesViewController: AllRatesViewProtocol {
    
    func setTitle(with title: String) {
        self.title = title
    }
    
    func fetchRates() async {
        await MainActor.run {
            collectionView.reloadData()
        }
    }
}
