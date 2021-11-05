import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewSelf: MenuView! {
        guard isViewLoaded else { return nil }
        return (view as! MenuView)
    }
    
    var storeManager = StoreManager()
    let priceManager = PriceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.menuTable.delegate = self
        viewSelf.menuTable.dataSource = self
        
        priceManager.getPricesForInApps(inAppsIDs: ["booplink.coffee", "booplink.fullversion"])
        
        ///
        NotificationCenter.default.addObserver(forName: nPricesUpdated, object: nil, queue: nil) { notification in
            print("Обновление цен")
            
            print(UserDefaults.standard.object(forKey: "booplink.coffee"))
            print(UserDefaults.standard.object(forKey: "booplink.fullversion"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewSelf.configure()
        viewSelf.menuTable.reloadData()
    }
    
    ///
    func openArchive() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }

    ///
    func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {return}
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
            print("Settings opened: \(success)")
            })
        }
    }

    ///
    func openAppStore() {
        if let url = URL(string: "itms-apps://apple.com/app/id1556606517") {
            UIApplication.shared.open(url)
        }
    }
    
    ///
    func setDescriptionArchive(completion: @escaping (String) -> ()) {
        ParseArhive.parse { array in
            if array.isEmpty {
                completion(AppLanguage.dictionary["archiveIsEmpty"]!.stringValue )
            } else {
                completion(AppLanguage.dictionary["archiveDescription"]!.stringValue + " \(array.count)")
            }
        }
    }

    ///
    func shareThisApp() {
        let description = AppLanguage.dictionary["shareDescription"]!.stringValue
        let link = URL(string: "https://apps.apple.com/ru/app/booplink/id1556606517")
        let dataImage = UIImage(named: "logoShare")?.pngData()
        let viewController = UIActivityViewController(activityItems: [description, link!, dataImage as Any], applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = self.view
        self.present(viewController, animated: true, completion: nil)
    }
    
    ///
    func getProVersion() {
        print("getProVersion")
        storeManager.buyInApp(inAppID: "booplink.fullversion")
    }

    ///
    func resumePurchase() {
        print("resumePurchase")
        storeManager.restorePurchase()
    }

    ///
    func reward() {
        print("reward")
        storeManager.buyInApp(inAppID: "booplink.coffee")
    }

    ///
    @IBAction func changeLanguage(_ sender: UIButton) {
        UserDefaults.standard.set(sender.tag, forKey: "TagSelectLanguage")
        UserDefaults.standard.synchronize()
        AppLanguage.setLanguage()
        viewSelf.configure()
        viewSelf.menuTable.reloadData()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
