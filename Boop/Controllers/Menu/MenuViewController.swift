import UIKit

class MenuViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var viewSelf: MenuView! {
        guard isViewLoaded else { return nil }
        return (view as! MenuView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        viewSelf.menuTable.delegate = self
        viewSelf.menuTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewSelf.configure()
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
    func shareThisApp() {
        let description = "Приложение для сокращения URL"
        let link = "https://apps.apple.com/ru/app/booplink/id1556606517"
        let dataImage = UIImage(named: "logoShare")?.pngData()
        let viewController = UIActivityViewController(activityItems: [description, link, dataImage as Any], applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = self.view
        self.present(viewController, animated: true, completion: nil)
    }
    
    ///
    func removeAD() {
        print("removeAD")
    }

    ///
    func resumePurchase() {
        print("resumePurchase")
    }

    ///
    func reward() {
        print("reward")
    }

    ///
    @IBAction func changeLanguage(_ sender: UIButton) {
        UserDefaults.standard.set(sender.tag, forKey: "TagSelectLanguage")
        UserDefaults.standard.synchronize()
        AppLanguage.setLanguage()
        
        self.view.layoutIfNeeded()
        viewDidLoad()
        viewSelf.menuTable.reloadData()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



//extension MenuViewController: UIActivityItemSource {
//
//    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
//        return ""
//    }
//
//    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
//        return URL.init(string: "https://itunes.apple.com/app/id1170886809")!
//    }
//
//    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
//        return "ScreenSort for iOS: https://itunes.apple.com/app/id1170886809"
//    }
//
//    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
//        return nil
//    }
//}
