import UIKit
import GoogleMobileAds

class StartViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    
    static let shared = StartViewController()
    
    var viewSelf: StartView! {
        guard isViewLoaded else { return nil }
        return (view as! StartView)
    }
    
    enum Service: String {
        case Isgd = "https://is.gd/*"
        case Shortener = "https://goolnk.com/*"
        case TinyURL = "https://tiny.one/*"
        case Click = "https://clck.ru/*"
    }
    
    let pasteboard = UIPasteboard.general
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var longLink: String!
    var shortLink: String!
    var pressedButtonTag: Int!
    var arrayKeysServices: [Service] = [.Isgd, .Shortener, .TinyURL, .Click]
    var indexSelectedService = 0
    static var selectedService: Service = .Isgd
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.collectionServices.delegate = self
        viewSelf.collectionServices.dataSource = self
        viewSelf.configure()
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
        viewSelf.pagination.numberOfPages = arrayKeysServices.count
        viewSelf.pagination.currentPage = indexSelectedService
        viewSelf.pagination.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    /// получение номера версии приложения
    func getVersionApp() {
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        viewSelf.versionLabel.text = "version: \(version)"
    }
    
    ///
    func createShortLink() {
        API.post(inputLongLink: longLink) { (responseShortLink) in
            print("short link: \(responseShortLink)")
            self.viewSelf.placeLinkButton.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                if responseShortLink != "" {
                    self.showResult(resutShortUrl: responseShortLink)
                } else {
                    self.viewSelf.showMessage(text: "ERROR ☹️")
                }
            }
        }
    }
    
    func showResult(resutShortUrl: String) {
        self.viewSelf.showMessage(text: "DONE 🤗")
        self.viewSelf.linkLabel.text = resutShortUrl
        self.shortLink = resutShortUrl
        self.viewSelf.alphaStackActionButtons(valueAlpha: 1.0, duration: 0.2)
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
        present(shareController, animated: true)
    }
    
    ///
    func showQRCode() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
        vc.linkForQRCode = shortLink
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    ///
    func copiedShortLink() {
        pasteboard.string = self.shortLink
        viewSelf.showMessage(text: "Link copied")
    }
    
    ///
    @IBAction func openArchiveAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController") as! ArchiveViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
