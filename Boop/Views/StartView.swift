import UIKit

class StartView: UIView {
    
    @IBOutlet weak var backViewLink: UIView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var placeLinkButton: UIButton!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var stackActionButtons: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var collectionServices: UICollectionView!
    @IBOutlet weak var pagination: UIPageControl!
    
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
            UIView.animate(withDuration: 0.1, delay: 1.0, options: .curveLinear, animations: {
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
