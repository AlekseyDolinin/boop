import UIKit

class QRCodeModalVC: UIViewController {

    private let backView = UIView()
    private let qrCodeImage = UIImageView()
    private let linkLabel = UILabel()
    private let shareButton = UIButton()
    
    var longLink = ""
    var shortLink = ""
    
    init(shortLink: String) {
        self.shortLink = shortLink
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        view.backgroundColor = .white
    }
    
    private func convert(cmage: CIImage) -> UIImage {
        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    @objc private func shareAction(_ sender: UIButton) {
        print("shareAction")
        let renderer = UIGraphicsImageRenderer(size: backView.bounds.size)
        let renderImage: UIImage = renderer.image { ctx in
            backView.drawHierarchy(in: backView.bounds, afterScreenUpdates: true)
        }
        
        let shareController = UIActivityViewController(activityItems: [renderImage.pngData() as Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                print("it is done!")
            } else {
                print("error send")
            }
        }
        present(shareController, animated: true, completion: nil)

    }
}


extension QRCodeModalVC {
    
    private func createSubviews() {
        createBackView()
        createQRCodeImage()
        createLinkLabel()
        createShareButton()
    }
    
    private func createBackView() {
        view.addSubview(backView)
        //
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        backView.heightAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
    }
    
    private func createQRCodeImage() {
        backView.addSubview(qrCodeImage)
        guard let url = URL(string: shortLink)?.qrImage(using: .black) else { return }
        qrCodeImage.image = convert(cmage: url)
        //
        qrCodeImage.translatesAutoresizingMaskIntoConstraints = false
        qrCodeImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 32).isActive = true
        qrCodeImage.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 32).isActive = true
        qrCodeImage.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -32).isActive = true
        qrCodeImage.heightAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
    }
    
    private func createLinkLabel() {
        backView.addSubview(linkLabel)
        linkLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        linkLabel.textColor = .darkText
        linkLabel.textAlignment = .center
        linkLabel.text = shortLink
        //
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        linkLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10).isActive = true
        linkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func createShareButton() {
        view.addSubview(shareButton)
        shareButton.tintColor = .Violet_Dark_
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: configuration)
        shareButton.setImage(image, for: .normal)
        shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        //
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        shareButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        shareButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
    }
}







extension URL {
    
    /// Creates a QR code for the current URL in the given color.
    func qrImage(using color: UIColor, logo: UIImage? = nil) -> CIImage? {
        let tintedQRImage = qrImage?.tinted(using: color)
        
        guard let logo = logo?.cgImage else {
            return tintedQRImage
        }
        
        return tintedQRImage?.combined(with: CIImage(cgImage: logo))
    }
    
    /// Returns a black and white QR code for this URL.
    var qrImage: CIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let qrData = absoluteString.data(using: String.Encoding.ascii)
        qrFilter.setValue(qrData, forKey: "inputMessage")
        
        let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
        return qrFilter.outputImage?.transformed(by: qrTransform)
    }
}
