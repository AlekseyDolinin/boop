import UIKit
import GoogleMobileAds

class ArchiveViewController: UIViewController, GADBannerViewDelegate {

    
    var viewSelf: ArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! ArchiveView)
    }
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGadBanner()
        
    }
}



import UIKit

class ArchiveView: UIView {
    
    
    override func awakeFromNib() {

        
        
    }
    
    
    func configure() {

    }
}
