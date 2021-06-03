import UIKit

extension StartViewController {

    ///
    @IBAction func action(_ sender: UIButton) {
        /// в зависимости от тэга - разные действия
        pressedButtonTag = sender.tag
        if interstitial.isReady == true {
            print("ролик готов")
            interstitial.present(fromRootViewController: self)
        }
    }
    
    ///
    @IBAction func backAction(_ sender: UIButton) {
        startView.linkLabel.text = "Paste the link here"
        startView.alphaStackActionButtons(valueAlpha: 0.0, duration: 0.2)
    }
    
    ///
    @IBAction func tapPlaceLinkAction(_ sender: UIButton) {
        if startView.linkLabel.text == "Paste the link here" {
            let encodeString: String = (pasteboard.string)?.encodeUrl() ?? ""
            print("encodeString: \(encodeString)")
            print("selectedService: \(StartViewController.selectedService)")
            
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
