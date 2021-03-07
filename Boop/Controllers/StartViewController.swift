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
    
    
    enum Services: String {
        case urlShortenerService = "urlShortenerService"
        case rebrandly = "rebrandly"
        case tinyURL = "tinyURL"
        case bitly = "bitly"
        case tinycc = "tinycc"
        case chlli = "chlli"
        case isgd = "isgd"
        case polrproject = "polrproject"
        case adfly = "adfly"
        case shortio = "shortio"
        
    }
    
    var nameSelectedService: Services = .tinyURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startView.configure()
        setGadBanner()
        setGadFullView()
    }
    
    
    ///
    func createShortLink() {
        API.post(serviceName: nameSelectedService.rawValue, inputLongLink: longLink) { (responseShortLink) in
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
    
    
    ///
    func showControllerShare() {
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
    }
}
