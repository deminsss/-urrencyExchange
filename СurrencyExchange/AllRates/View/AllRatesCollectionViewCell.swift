import UIKit

final class AllRatesCollectionViewCell: UICollectionViewCell {
    static let identifier = "Cell"

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 30)
        return label
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 20)
        return label
    }()
        
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubviews(nameLabel, valueLabel)
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
        
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(
                equalTo: self.centerYAnchor, constant: -20),
            nameLabel.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            
            valueLabel.centerYAnchor.constraint(
                equalTo: self.centerYAnchor, constant: 15),
            valueLabel.centerXAnchor.constraint(
                equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
