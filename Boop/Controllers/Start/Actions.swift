import UIKit

extension StartViewController {

    ///
    @IBAction func action(_ sender: UIButton) {
        /// в зависимости от тэга - разные действия
        pressedButtonTag = sender.tag
        if interstitial.isReady == true {
            print("ролик готов")
            interstitial.present(fromRootViewController: self)
        } else {
            pressedButtonTag == 2 ? copiedShortLink() : showControllerShare()
        }
    }
    
    ///
    @IBAction func showQRCode(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
        vc.linkForQRCode = shortLink
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    ///
    @IBAction func openMenu(_ sender: Any?) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    ///
    @IBAction func backAction(_ sender: UIButton) {
        viewSelf.linkLabel.text = "Paste the link here"
        viewSelf.alphaStackActionButtons(valueAlpha: 0.0, duration: 0.2)
        self.longLink = nil
        self.shortLink = nil
    }
    
    ///
    @IBAction func saveLinkAction(_ sender: UIButton) {
        print("saveLinkAction")
        animationSaveInArchive()
        animationPulse()
        addItemInArchive()
    }
    
    
    ///
    @IBAction func openArchiveAction(_ sender: Any?) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    ///
    @IBAction func tapPlaceLinkAction(_ sender: UIButton) {
        print("tapPlaceLinkAction")
        if viewSelf.linkLabel.text == "Paste the link here" {
            let encodeString: String = (pasteboard.string)?.encodeUrl() ?? ""
            print("encodeString: \(encodeString)")
            print("selectedService: \(StartViewController.selectedService)")
            /// проверка вставлена ссылка или просто текст
            if let longLink = URL(string: encodeString), let scheme = longLink.scheme {
                if scheme == "https" || scheme == "http" {
                    viewSelf.showMessage(text: "Please Wait...")
                    viewSelf.linkLabel.text = pasteboard.string
                    self.longLink = longLink.absoluteString
                    self.viewSelf.placeLinkButton.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.createShortLink()
                    }
                    self.viewSelf.animationLabel()
                }
            } else {
                viewSelf.showMessage(text: "Not Found Link \n(Please, copy url to clipboard)")
            }
        }
    }
}
