import UIKit
import GoogleMobileAds

let nArchiveItemEdit: NSNotification.Name = NSNotification.Name(rawValue: "nArchiveItemEdit")

class ArchiveViewController: UIViewController, GADBannerViewDelegate {
    
    var viewSelf: ArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! ArchiveView)
    }
    
    var arrayArchive = [ArchiveItem]()
    var bannerView: GADBannerView!
    let pasteboard = UIPasteboard.general
    var shortLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.archiveTable.delegate = self
        viewSelf.archiveTable.dataSource = self
        
        parseArchive()
        
        if StoreManager.isFullVersion() == false {
            setGadBanner()
        }
        
        /// 
        NotificationCenter.default.addObserver(forName: nArchiveItemEdit, object: nil, queue: nil) { notification in
            self.parseArchive()
        }
    }
    
    // парсинг архива при первом заходе и при изменении данных по ссылке
    func parseArchive() {
        
        // запись обновлённого массива ссылок в дефолт
        Archive.saveArchive(arrayArchive: SplashViewController.archive)
        
        // парсинг обновлённого массива ссылок
        Archive.parse(completion: { array in
            self.viewSelf.emptyLabel.isHidden = array.isEmpty ? false : true
            self.arrayArchive = array.isEmpty ? [] : array
            self.viewSelf.archiveTable.reloadData()
        })
    }
    
    ///
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
