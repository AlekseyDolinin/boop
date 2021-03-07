import UIKit

class QRCodeModalViewController: UIViewController {

    var qrCodeModalView: QRCodeModalView! {
        guard isViewLoaded else {return nil}
        return (view as! QRCodeModalView)
    }
    
    var linkForQRCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qrURLImage = URL(string: "https://www.avanderlee.com")?.qrImage(using: UIColor(named: "Violet_Dark_")!)
        qrCodeModalView.qrCodeImage.image = convert(cmage: qrURLImage!)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    func convert(cmage:CIImage) -> UIImage {
        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    @IBAction func closeView (_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
