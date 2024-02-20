import UIKit
import LinkPresentation

class MenuFullVersionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewSelf: MenuView! {
        guard isViewLoaded else { return nil }
        return (view as! MenuView)
    }
    
    var urlToShare: URL? = URL(string: "https://apps.apple.com/ru/app/booplink/id1556606517")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.menuTable.delegate = self
        viewSelf.menuTable.dataSource = self
        
        viewSelf.menuTable.reloadData()
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
        Archive.parse { array in
            if array.isEmpty {
                completion(AppLanguage.dictionary["archiveIsEmpty"]!.stringValue )
            } else {
                completion(AppLanguage.dictionary["archiveDescription"]!.stringValue + " \(array.count)")
            }
        }
    }

    ///
    func shareThisApp() {
        let viewController = UIActivityViewController(activityItems: [urlToShare as Any], applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = self.view
        self.present(viewController, animated: true, completion: nil)
    }

    ///
    func support() {
        print("support")
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

extension MenuFullVersionViewController: UIActivityItemSource {

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage() // an empty UIImage is sufficient to ensure share sheet shows right actions
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return urlToShare
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
//        metadata.title = AppLanguage.dictionary["shareDescription"]!.stringValue
//        metadata.originalURL = urlToShare
//        metadata.url = urlToShare
//        metadata.imageProvider = NSItemProvider.init(contentsOf: urlToShare)
//        metadata.iconProvider = NSItemProvider.init(contentsOf: urlToShare)
        return metadata
    }
}
