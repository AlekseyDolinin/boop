import UIKit

public class Loader: UIView {
    
    private let loaderBack = UIView()
    private let loader = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension Loader {
    private func createSubViews() {
        createLoaderBack()
        createLoader()
    }

    private func createLoaderBack() {
        addSubview(loaderBack)
        loaderBack.backgroundColor = .black.withAlphaComponent(0.75)
        loaderBack.layer.cornerRadius = 16.0
        loaderBack.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        //
        loaderBack.translatesAutoresizingMaskIntoConstraints = false
        loaderBack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loaderBack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loaderBack.widthAnchor.constraint(equalToConstant: 80).isActive = true
        loaderBack.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func createLoader() {
        loaderBack.addSubview(loader)
        loader.style = .medium
        loader.color = .white
        loader.startAnimating()
        //
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: loaderBack.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: loaderBack.centerYAnchor).isActive = true
    }
}



fileprivate class BGLoader: UIView {
    
    private let backView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension BGLoader {
    private func createSubViews() {
        createLoaderBack()
    }

    private func createLoaderBack() {
        addSubview(backView)
        backView.backgroundColor = .black.withAlphaComponent(0.7)
        //
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
