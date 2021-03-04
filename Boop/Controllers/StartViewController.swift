import UIKit
import GoogleMobileAds

class StartViewController: UIViewController,  GADBannerViewDelegate, GADInterstitialDelegate {
    
    var startView: StartView! {
        guard isViewLoaded else { return nil }
        return (view as! StartView)
    }
    
    let pasteboard = UIPasteboard.general
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    var countShowFullViewAds = 0
    
    var longLink: String!
    var shortLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startView.configure()
        setGadBanner()
        setGadFullView()
    }

    func createShortLink() {
        API.post(longLink: self.longLink) { (responseShortLink) in

            print("response short link = \(responseShortLink)")

            DispatchQueue.main.async {
                if responseShortLink != "" {
                    self.startView.showMessage(text: "DONE 🤗")
                    self.startView.linkLabel.text = responseShortLink
                    self.shortLink = responseShortLink
                    self.startView.alphaStackActionButtons(valueAlpha: 1.0, duration: 0.2)
                    self.startView.placeLinkButton.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    func showControllerShare() {
        
//        if let dataGifForSend = dataGif {
        let shareController = UIActivityViewController(activityItems: [shortLink as Any], applicationActivities: nil)
            shareController.completionWithItemsHandler = {_, bool, _, _ in
                if bool {
                    print("it is done!")
                } else {
                    print("error send")
                }
            }
            countShowFullViewAds = countShowFullViewAds + 1
            present(shareController, animated: true, completion: nil)
//        }
    }
    
    @IBAction func tapPlaceLinkAction(_ sender: UIButton) {
        
        if startView.linkLabel.text == "Paste the link here" {
        
            let encodeString: String = (pasteboard.string)?.encodeUrl() ?? ""
            
            print("encodeString: \(encodeString)")
            
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
