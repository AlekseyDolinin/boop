import UIKit

extension StartViewController {

    
    ///
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
    
    
    ///
    @IBAction func copyAction(_ sender: UIButton) {
        pasteboard.string = self.shortLink
        startView.showMessage(text: "Link copied")
    }
    
    
    ///
    @IBAction func backAction(_ sender: UIButton) {
        startView.linkLabel.text = "Paste the link here"
        startView.alphaStackActionButtons(valueAlpha: 0.0, duration: 0.2)
    }
    
    
    ///
    @IBAction func generateQRCode(_ sender: UIButton) {
        print("generateQRCode")
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
        vc.linkForQRCode = shortLink
        present(vc, animated: true)
    }
    
    
    ///
    @IBAction func tapPlaceLinkAction(_ sender: UIButton) {
        if startView.linkLabel.text == "Paste the link here" {
            let encodeString: String = (pasteboard.string)?.encodeUrl() ?? ""
            print("encodeString: \(encodeString)")
            
            /// проверка вставлена ссылка или просто текст
            if let longLink = URL(string: encodeString), let scheme = longLink.scheme {
                
                let host: String! = longLink.host
                
                if host == "goolnk.com" {
                    startView.showMessage(text: "Not Found Link")
                    return
                }
                if scheme == "https" || scheme == "http" {
                    startView.showMessage(text: "Please Wait...")
                    startView.linkLabel.text = pasteboard.string
                    self.longLink = longLink.absoluteString
                    self.startView.placeLinkButton.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.createShortLink()
                    }
                    self.startView.animationLabel()
                }
            } else {
                startView.showMessage(text: "Not Found Link")
            }
        }
    }
}
