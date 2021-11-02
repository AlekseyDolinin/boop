import UIKit
import GoogleMobileAds
import SwiftyJSON
import Foundation

class StartViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate, UIGestureRecognizerDelegate {
    
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
    
    static var selectedService: Service = .Isgd
    
    let pasteboard = UIPasteboard.general
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var longLink: String!
    var shortLink: String!
    var pressedButtonTag: Int!
    var arrayKeysServices: [Service] = [.Isgd, .Shortener, .TinyURL, .Click]
    var indexSelectedService = 0
    var arrayArchive = [ArchiveItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.collectionServices.delegate = self
        viewSelf.collectionServices.dataSource = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        viewSelf.configure()
        setGadBanner()
        setGadFullView()
        setPagination()
        checkAppTrackingTransparency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewSelf.configure()
        ParseArhive.parse { array in
            self.arrayArchive = array
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
    func copiedShortLink() {
        pasteboard.string = self.shortLink
        viewSelf.showMessage(text: AppLanguage.dictionary["linkCopied"]!.stringValue)
    }
    
    ///
    func createItem() -> ArchiveItem {
        return ArchiveItem(id: UUID().uuidString,
                           name: createName(longURL: self.longLink),
                           description: nil,
                           shortLink: self.shortLink,
                           longLink: self.longLink,
                           date: Date())
    }
    
    ///
    func createName(longURL: String) -> String {
        let url = URL(string: longURL)
        let nameItem = (url?.lastPathComponent)?.capitalizingFirstLetter()
        return nameItem ?? "Name"
    }
    
    ///
    func addItemInArchive() {
        ///проверка количества записей
        if self.arrayArchive.count >= 10 {
            self.showAlert()
        } else {
            self.arrayArchive.append(self.createItem())
            ParseArhive.saveArchive(arrayArchive: self.arrayArchive)
        }
    }
    
    ///
    func openArchive() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    ///
    func showAlert() {
        
        let titleFullArchive = AppLanguage.dictionary["archiveIsEmpty"]!.stringValue
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
