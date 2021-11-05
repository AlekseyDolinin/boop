import UIKit

extension StartViewController {

    ///
    @IBAction func copyAction(_ sender: UIButton) {
        if StoreManager.isFullVersion() {
            copiedShortLink()
        } else {
            if interstitial.isReady == true {
                print("ролик готов")
                action = .copy
                interstitial.present(fromRootViewController: self)
            } else {
                copiedShortLink()
            }
        }
    }
    
    ///
    @IBAction func shareAaction(_ sender: UIButton) {
        if StoreManager.isFullVersion() {
            showControllerShare()
        } else {
            if interstitial.isReady == true {
                print("ролик готов")
                action = .share
                interstitial.present(fromRootViewController: self)
            } else {
                showControllerShare()
            }
        }
    }
    
    ///
    @IBAction func showQRCode(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
        vc.linkForQRCode = StartViewController.shortLink
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
        viewSelf.linkLabel.text = AppLanguage.dictionary["pasteLinkHere"]!.stringValue
        viewSelf.alphaStackActionButtons(valueAlpha: 0.0, duration: 0.2)
        self.longLink = nil
        StartViewController.shortLink = nil
    }
    
    ///
    @IBAction func saveLinkAction(_ sender: UIButton) {
        viewSelf.animationSaveInArchive()
        viewSelf.animationPulse()
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
        if viewSelf.linkLabel.text == AppLanguage.dictionary["pasteLinkHere"]!.stringValue {
            let encodeString: String = (pasteboard.string)?.encodeUrl() ?? ""
            print("encodeString: \(encodeString)")
            print("selectedService: \(StartViewController.selectedService)")
            /// проверка вставлена ссылка или просто текст
            if let longLink = URL(string: encodeString), let scheme = longLink.scheme {
                if scheme == "https" || scheme == "http" {
                    viewSelf.showMessage(text: AppLanguage.dictionary["pleaseWait"]!.stringValue)
                    viewSelf.linkLabel.text = pasteboard.string
                    self.longLink = longLink.absoluteString
                    self.viewSelf.placeLinkButton.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.createShortLink()
                    }
                }
            } else {
                viewSelf.showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
            }
        }
    }
}
