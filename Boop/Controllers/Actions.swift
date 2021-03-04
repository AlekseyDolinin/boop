import UIKit

extension StartViewController {

    @IBAction func shareAction(_ sender: UIButton) {
        print("share")
        if interstitial.isReady == true && countShowFullViewAds % 2 == 0 && countShowFullViewAds > 0 {
            print("ролик готов")
            interstitial.present(fromRootViewController: self)
        } else {
            print("showControllerShare")
            showControllerShare()
        }
    }
    
    @IBAction func copyAction(_ sender: UIButton) {
        pasteboard.string = self.shortLink
        startView.showMessage(text: "Link copied")
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        startView.linkLabel.text = "Paste the link here"
        self.startView.alphaStackActionButtons(valueAlpha: 0.0, duration: 0.2)
    }
}
