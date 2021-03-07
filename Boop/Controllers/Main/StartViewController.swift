import UIKit
import GoogleMobileAds

class StartViewController: UIViewController,  GADBannerViewDelegate, GADInterstitialDelegate {
    
    static let shared = StartViewController()
    
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
    
    enum KeysService: String {
        case Rebrandly = "rebrand.ly/*******"
        case Chlli = "chl.li/*****"
        case Isgd = "https://is.gd/******"
        case Shortener = "https://goolnk.com/******"
        case TinyURL = "3"
        case Bitly = "4"
        case Tinycc = "5"
        case Polrproject = "8"
        case Adfly = "9"
        case Shortio = "10"
    }
    
    var arrayKeysServices: [KeysService] = [.Rebrandly, .Chlli, .Isgd, .Shortener/*, .TinyURL, .Bitly, .Tinycc, .Polrproject, .Adfly, .Shortio*/]
    
    var indexSelectedService = 0
    static var selectedService: KeysService = .Shortener
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.collectionServices.delegate = self
        startView.collectionServices.dataSource = self
        startView.configure()
        setGadBanner()
        setGadFullView()
        setPagination()
    }
    
    func setPagination() {
        startView.pagination.numberOfPages = arrayKeysServices.count
        startView.pagination.currentPage = indexSelectedService
        startView.pagination.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    ///
    func createShortLink() {
        API.post(inputLongLink: longLink) { (responseShortLink) in
            print("response short link: \(responseShortLink)")
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
