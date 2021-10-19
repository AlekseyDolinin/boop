import UIKit
import GoogleMobileAds

class ArchiveViewController: UIViewController, GADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var viewSelf: ArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! ArchiveView)
    }
    var arrayArchive = [ArchiveLink]()
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSelf.archiveTable.delegate = self
        viewSelf.archiveTable.dataSource = self
        
        setGadBanner()
        
        navigationController?.title = "Archive"
        
    }
}
