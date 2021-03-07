import UIKit

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
