import UIKit
import GoogleMobileAds

class StartViewController: UIViewController,  GADBannerViewDelegate, GADInterstitialDelegate {
    
    static let shared = StartViewController()
    
    var startView: StartView! {
        guard isViewLoaded else { return nil }
        return (view as! StartView)
    }
    
    enum KeysService: String {
        case Chlli = "chl.li/*****"
        case Isgd = "https://is.gd/******"
        case Shortener = "https://goolnk.com/******"
        case Bitly = "4"
        case Tinycc = "5"
        case Polrproject = "8"
        case Adfly = "9"
        case Shortio = "10"
        case Click = "https://clck.ru"
        case Lnnkin = "https://www.lnnkin.com/api-integration/guide"
        case ToClick = "https://to.click"
        case TinyURL = "http://www.tiny-url.info"
    }
    
    let pasteboard = UIPasteboard.general
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var countShowFullViewAds = 0
    var longLink: String!
    var shortLink: String!
    var pressedButtonTag: Int!
    var arrayKeysServices: [KeysService] = [.Chlli, .Isgd, .Shortener/*, .TinyURL, .Bitly, .Tinycc, .Polrproject, .Adfly, .Shortio*/]
    var indexSelectedService = 0
    static var selectedService: KeysService = .Chlli
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.collectionServices.delegate = self
        startView.collectionServices.dataSource = self
        startView.configure()
        setGadBanner()
        setGadFullView()
        setPagination()
        getVersionApp()
        
        #if canImport(AppTrackingTransparency)
        NotificationCenter.default.addObserver(self, selector: #selector(requestTrackingAuthorization), name: Notification.Name("requestAppTracking"), object: nil)
        
        if let statusATT =  UserDefaults.standard.string(forKey: "statusATTKey") {
            print("statusATT: \(statusATT)")
            if statusATT == "notDetermined" {
                showModalAppTrackingDescription()
            }
        } else {
            /// если статус нил - запроса не было
            showModalAppTrackingDescription()
        }
        #endif
    }
    
    ///
    func setPagination() {
        startView.pagination.numberOfPages = arrayKeysServices.count
        startView.pagination.currentPage = indexSelectedService
        startView.pagination.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    /// получение номера версии приложения
    func getVersionApp() {
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        startView.versionLabel.text = "version: \(version)"
    }
    
    ///
    func createShortLink() {
        API.post(inputLongLink: longLink) { (responseShortLink) in
            print("short link: \(responseShortLink)")
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
        present(shareController, animated: true, completion: nil)
    }
    
    ///
    func showQRCode() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
        vc.linkForQRCode = shortLink
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
}
