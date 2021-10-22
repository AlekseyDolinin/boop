import UIKit
import GoogleMobileAds

class QRCodeModalViewController: UIViewController, GADInterstitialDelegate {

    var qrCodeModalView: QRCodeModalView! {
        guard isViewLoaded else {return nil}
        return (view as! QRCodeModalView)
    }
    
    var linkForQRCode: String!
    var dataImageQRCode: Data!
    var interstitial: GADInterstitial!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setGadFullView()
//        let imageLogo = UIImage(named: "circleLogo")!
//        let qrURLImage = URL(string: linkForQRCode)?.qrImage(using: UIColor(named: "Violet_Dark_")!, logo: imageLogo)
        let qrURLImage = URL(string: linkForQRCode)?.qrImage(using: UIColor(named: "Violet_Dark_")!)
        qrCodeModalView.qrCodeImage.image = convert(cmage: qrURLImage!)
        qrCodeModalView.linkLabel.text = linkForQRCode
        
        if #available(iOS 13, *) {
            qrCodeModalView.closeButton.isHidden = true
        } else {
            qrCodeModalView.closeButton.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        /// рендер UIImage
        let renderer = UIGraphicsImageRenderer(size: qrCodeModalView.backView.bounds.size)
        let renderImage: UIImage = renderer.image { ctx in
            qrCodeModalView.backView.drawHierarchy(in: qrCodeModalView.backView.bounds, afterScreenUpdates: true)
        }
        /// Convert to data
        dataImageQRCode = renderImage.pngData()
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
    
    ///
    func convert(cmage: CIImage) -> UIImage {
        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    ///
    func shareQRCode() {
        let shareController = UIActivityViewController(activityItems: [dataImageQRCode as Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                print("it is done!")
            } else {
                print("error send")
            }
        }
        present(shareController, animated: true, completion: nil)
    }
    
    ///
    @IBAction func closeView (_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    ///
    @IBAction func shareAction (_ sender: UIButton) {
        if interstitial.isReady == true {
            print("ролик готов")
            interstitial.present(fromRootViewController: self)
        } else {
            shareQRCode()
        }
    }
    
    ///
    @IBAction func saveQRCode (_ sender: UIButton) {
        print("saveQRCode")
    }
}
