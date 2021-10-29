import UIKit

class QRCodeModalView: UIView {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var qrCodeImage: UIImageView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        setUI()
    }
    
}


extension QRCodeModalView {
    
    ///
    func setUI() {
        setLabels()
        
        /// Color

        ///
        shareButton.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.tintColor = .black
        
        ///
        logo.image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
        logo.tintColor = .black
    }
    
    ///
    func setLabels() {

    }
}
