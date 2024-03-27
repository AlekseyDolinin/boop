import UIKit

final class ServiceCard: UIView {
            
    private let backView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
            
    init(frame: CGRect, title: String, subtitle: String) {
        super.init(frame: frame)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
    
    
extension ServiceCard {
    
    private func createSubviews() {
        createBackView()
        createtTitleLabel()
        createSubtitleLabel()
    }
    
    private func createBackView() {
        addSubview(backView)
        backView.backgroundColor = .white.withAlphaComponent(0.5)
        backView.layer.cornerRadius = 8.0
        //
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
    }
    
    private func createtTitleLabel() {
        backView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        //
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -12).isActive = true
    }
    
    private func createSubtitleLabel() {
        backView.addSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .black
        subtitleLabel.textAlignment = .center
        //
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 12).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -12).isActive = true
    }
}
