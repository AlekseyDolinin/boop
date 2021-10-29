import UIKit

class StartView: UIView {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var generationQRButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveInArchiveButton: UIButton!
    @IBOutlet weak var backViewLink: UIView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var placeLinkButton: UIButton!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var stackActionButtons: UIStackView!
    @IBOutlet weak var collectionServices: UICollectionView!
    @IBOutlet weak var pagination: UIPageControl!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var openArchiveButton: UIButton!

    override func awakeFromNib() {
        setUI()
    }
    
    func configure() {
        
        backViewLink.layer.cornerRadius = backViewLink.frame.height / 2
        alphaStackActionButtons(valueAlpha: 0.0, duration: 0.0)
        viewMessage.alpha = 0
    }
    
    func showMessage(text: String) {
        textMessage.text = text
        
        UIView.animate(withDuration: 0.1, animations: {
            self.viewMessage.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.1, delay: 2.0, options: .curveLinear, animations: {
                self.viewMessage.alpha = 0
            }, completion: { (true) in
                print("hide message")
            })
        }
    }
    
    func animationLabel() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.linkLabel.alpha = 0
        }) { (true) in
            UIView.animate(withDuration: 0.1, animations: {
                self.linkLabel.alpha = 1
            })
        }
    }
    
    func alphaStackActionButtons(valueAlpha: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration) {
            self.stackActionButtons.alpha = valueAlpha
        }
    }
}

extension StartView {
    
    ///
    func setUI() {
        setLabels()
        
        /// Color
        
        ///
        menuButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        copyButton.setImage(UIImage(named: "copy")?.withRenderingMode(.alwaysTemplate), for: .normal)
        generationQRButton.setImage(UIImage(named: "qr")?.withRenderingMode(.alwaysTemplate), for: .normal)
        shareButton.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        saveInArchiveButton.setImage(UIImage(named: "markInArchive")?.withRenderingMode(.alwaysTemplate), for: .normal)
        openArchiveButton.setImage(UIImage(named: "archiveIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        menuButton.tintColor = .black
        backButton.tintColor = .black
        copyButton.tintColor = .black
        generationQRButton.tintColor = .black
        shareButton.tintColor = .black
        saveInArchiveButton.tintColor = .black
        
        ///
        viewMessage.clipsToBounds = true
        viewMessage.layer.cornerRadius = 4
        openArchiveButton.layer.cornerRadius = openArchiveButton.frame.height / 2
    }
    
    ///
    func setLabels() {

    }
}
