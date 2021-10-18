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
            switch pressedButtonTag {
            case 2:
                copiedShortLink()
            case 3:
                showQRCode()
            case 4:
                showControllerShare()
            default:
                break
            }
        }
    }
    
    ///
    @IBAction func backAction(_ sender: UIButton) {
        viewSelf.linkLabel.text = "Paste the link here"
        viewSelf.alphaStackActionButtons(valueAlpha: 0.0, duration: 0.2)
        self.longLink = nil
        self.shortLink = nil
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
                
//                let host: String! = longLink.host
//                print(host)
//
//
//
//                if host == "goolnk.com" {
//                    startView.showMessage(text: "Not Found Link (Please, copy url to clipboard)")
//                    return
//                }
                
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
