import UIKit
//import GoogleMobileAds

class StartViewController: UIViewController/*,  GADBannerViewDelegate*/ {
    
    var startView: StartView! {
        guard isViewLoaded else { return nil }
        return (view as! StartView)
    }
    
    let pasteboard = UIPasteboard.general
//    var bannerView: GADBannerView!
    var longLink: String!
    var shortLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startView.configure()
//        setGadBanner()
        
    }

    func createShortLink() {
        API.post(longLink: self.longLink) { (responseShortLink) in

            print("response short link = \(responseShortLink)")

            DispatchQueue.main.async {
                if responseShortLink != "" {
                    self.startView.showMessage(text: "DONE 🤗")
                    self.startView.linkLabel.text = responseShortLink
                    self.shortLink = responseShortLink
                    self.startView.clearButton.isHidden = false
                    self.startView.placeLinkButton.isUserInteractionEnabled = true
                }
            }
        }
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
            
        } else {
            pasteboard.string = self.shortLink
            startView.showMessage(text: "Link copied")
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        startView.linkLabel.text = "Paste the link here"
        self.startView.clearButton.isHidden = true
    }
}
