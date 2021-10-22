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
    
    let pasteboard = UIPasteboard.general
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var longLink: String!
    var shortLink: String!
    var pressedButtonTag: Int!
    var arrayKeysServices: [Service] = [.Isgd, .Shortener, .TinyURL, .Click]
    var indexSelectedService = 0
    static var selectedService: Service = .Isgd
    var arrayArchive = [ArchiveLink]()
    
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
    
    ///
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
    func copiedShortLink() {
        pasteboard.string = self.shortLink
        viewSelf.showMessage(text: "Link copied")
    }
    
    ///
    func createItem() -> ArchiveLink{
        return ArchiveLink(id: UUID().uuidString,
                           name: nil,
                           description: nil,
                           shortLink: self.shortLink,
                           longLink: self.longLink,
                           date: Date())
    }
    
    ///
    func wrireArchive(completion: @escaping (Bool) -> ()) {
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                self.arrayArchive = try decoder.decode([ArchiveLink].self, from: data)
                completion (true)
            } catch {
                print("Unable to Decode Notes (\(error))")
                completion (false)
            }
        }
    }
    
    ///
    func addItemInArchive() {
        ///
        wrireArchive { bool in
            /// если удалось прочитать и декодировать архив
            if bool == true {
                ///проверка количества записей
                if self.arrayArchive.count >= 5 {
                    ///
                    self.showAlert()
                } else {
                    self.arrayArchive.append(self.createItem())
                    /// сортировка массива по дате
                    self.arrayArchive = self.arrayArchive.sorted {$0.date > $1.date}
                    self.saveArchive()
                }
            }
        }
    }
    
    ///
    func showAlert() {
        let alert = UIAlertController(title: "The archive is full", message: "You need to free up space", preferredStyle: .alert)
        let actionClose = UIAlertAction(title: "Close", style: .destructive)
        let actionGoToArchive = UIAlertAction(title: "Go to Archive", style: .default) { UIAlertAction in
            self.openArchiveAction(nil)
        }
        alert.addAction(actionGoToArchive)
        alert.addAction(actionClose)
        present(alert, animated: true)
    }
    
    ///
    func saveArchive() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.arrayArchive)
            UserDefaults.standard.set(data, forKey: "arrayArchive")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    ///
    func animationPulse() {
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.2
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1
        animationGroup.animations = [pulse1]
        self.viewSelf.openArchiveButton.layer.add(animationGroup, forKey: "pulse")
    }
}
