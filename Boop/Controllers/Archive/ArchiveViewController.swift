import UIKit
import GoogleMobileAds

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
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        Archive.parse(completion: { array in
            self.viewSelf.emptyLabel.isHidden = array.isEmpty ? false : true
            self.arrayArchive = array.isEmpty ? [] : array
        })
        
        if StoreManager.isFullVersion() == false {
            setGadBanner()
        }
    }
    
    ///
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
