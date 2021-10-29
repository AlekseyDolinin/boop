import UIKit
import GoogleMobileAds

class QRCodeModalViewController: UIViewController, GADInterstitialDelegate {

    var viewSelf: QRCodeModalView! {
        guard isViewLoaded else {return nil}
        return (view as! QRCodeModalView)
    }
    
    var linkForQRCode: String!
    var dataImageQRCode: Data!
    var interstitial: GADInterstitial!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setGadFullView()
        let qrURLImage = URL(string: linkForQRCode)?.qrImage(using: .black)
        viewSelf.qrCodeImage.image = convert(cmage: qrURLImage!)
        viewSelf.linkLabel.text = linkForQRCode
        
        if #available(iOS 13, *) {
            viewSelf.closeButton.isHidden = true
        } else {
            viewSelf.closeButton.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        /// рендер UIImage
        let renderer = UIGraphicsImageRenderer(size: viewSelf.backView.bounds.size)
        let renderImage: UIImage = renderer.image { ctx in
            viewSelf.backView.drawHierarchy(in: viewSelf.backView.bounds, afterScreenUpdates: true)
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
