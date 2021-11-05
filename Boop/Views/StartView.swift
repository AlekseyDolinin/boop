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

    var shortLink: String!
    
    override func awakeFromNib() {
        setUI()
    }
    
    func configure() {
        setUI()
        linkLabel.text = AppLanguage.dictionary["pasteLinkHere"]!.stringValue
        backViewLink.layer.cornerRadius = backViewLink.frame.height / 2
        viewMessage.alpha = 0
        if shortLink == nil {
            alphaStackActionButtons(valueAlpha: 0.0, duration: 0.0)
        } else {
            alphaStackActionButtons(valueAlpha: 1.0, duration: 0.0)
        }
    }
    
    ///
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
    
    ///
    func alphaStackActionButtons(valueAlpha: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration) {
            self.stackActionButtons.alpha = valueAlpha
        }
    }
    
    ///
    func animationSaveInArchive() {
        UIView.animate(withDuration: 0.4) {
            self.menuButton.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.menuButton.transform = CGAffineTransform(rotationAngle: Double.pi * 3)
        } completion: { bool in
            self.menuButton.transform = .identity
        }
    }
    
    ///
    func animationPulse() {
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.2
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1
        animationGroup.animations = [pulse1]
        openArchiveButton.layer.add(animationGroup, forKey: "pulse")
    }
}

extension StartView {
    ///
    func setUI() {
        setLabels()
                
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
//        linkLabel.text = AppLanguage.dictionary["pasteLinkHere"]!.stringValue
    }
}
