import UIKit
import GoogleMobileAds
import SwiftyJSON
import Foundation

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
    
    enum Actions: String {
        case copy = "copy"
        case share = "share"
        case none = "none"
    }
    
    static var selectedService: Service = .Isgd
    static var shortLink: String!
    
    let pasteboard = UIPasteboard.general
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var longLink: String!
    var arrayKeysServices: [Service] = [.Isgd, .Shortener, .TinyURL, .Click]
    var indexSelectedService = 0
    var action: Actions = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.collectionServices.delegate = self
        viewSelf.collectionServices.dataSource = self
        viewSelf.configure()
        setPagination()
        checkAppTrackingTransparency()
        ///
        NotificationCenter.default.addObserver(forName: nTransactionComplate, object: nil, queue: nil) { notification in
            if let banner = self.bannerView {
                banner.isHidden = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if StartViewController.shortLink == nil {
            self.viewSelf.configure()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if StoreManager.isFullVersion() == false {
            setGadBanner()
            setGadFullView()
        }
    }
    
    ///
    func setPagination() {
        viewSelf.pagination.numberOfPages = arrayKeysServices.count
        viewSelf.pagination.currentPage = indexSelectedService
        viewSelf.pagination.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    ///
    func createShortLink() {
        API.post(inputLongLink: longLink) { (responseShortLink) in
            self.viewSelf.placeLinkButton.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                if responseShortLink != "" {
                    self.showResult(resutShortUrl: responseShortLink)
                } else {
                    self.viewSelf.showMessage(text: AppLanguage.dictionary["errorMsg"]!.stringValue)
                }
            }
        }
    }
    
    ///
    func showResult(resutShortUrl: String) {
        self.viewSelf.showMessage(text: AppLanguage.dictionary["done"]!.stringValue)
        self.viewSelf.linkLabel.text = resutShortUrl
        StartViewController.shortLink = resutShortUrl
        self.viewSelf.shortLink = resutShortUrl
        self.viewSelf.alphaStackActionButtons(valueAlpha: 1.0, duration: 0.2)
    }
    
    ///
    func showControllerShare() {
        let shareController = UIActivityViewController(activityItems: [StartViewController.shortLink as Any], applicationActivities: nil)
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
    func copiedShortLink() {
        pasteboard.string = StartViewController.shortLink
        viewSelf.showMessage(text: AppLanguage.dictionary["linkCopied"]!.stringValue)
    }

    ///
    func addItemInArchive() {
        if StoreManager.isFullVersion() {
            Archive.addItemInArchive(longLink: self.longLink)
        } else {
            ///проверка количества записей
            if SplashViewController.archive.count >= 10 {
                self.showAlert()
            } else {
                Archive.addItemInArchive(longLink: self.longLink)
            }
        }
    }
    
    ///
    func openArchive() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    ///
    func showAlert() {
        
        let titleFullArchive = AppLanguage.dictionary["titleFullArchive"]!.stringValue
        let mesageFullArchive = AppLanguage.dictionary["messageFullArchive"]!.stringValue
        let close = AppLanguage.dictionary["close"]!.stringValue
        let gotoArchive = AppLanguage.dictionary["gotoArchive"]!.stringValue
        
        let alert = UIAlertController(title: titleFullArchive, message: mesageFullArchive, preferredStyle: .alert)
        let actionClose = UIAlertAction(title: close, style: .destructive)
        let actionGoToArchive = UIAlertAction(title: gotoArchive, style: .default) { UIAlertAction in
            self.openArchive()
        }
        alert.addAction(actionGoToArchive)
        alert.addAction(actionClose)
        present(alert, animated: true)
    }
}
