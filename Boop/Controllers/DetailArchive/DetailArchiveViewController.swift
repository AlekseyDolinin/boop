import UIKit
import SafariServices
import GoogleMobileAds

class DetailArchiveViewController: UIViewController, GADInterstitialDelegate {

    var viewSelf: DetailArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! DetailArchiveView)
    }
    
    var archiveItem: ArchiveItem!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSelf.archiveItemTable.delegate = self
        viewSelf.archiveItemTable.dataSource = self
        
        if StoreManager.isFullVersion() == false {
            setGadFullView()
        }
        
//        print(archiveItem.id)
//        print(archiveItem.name)
//        print(archiveItem.description)
//        print(archiveItem.shortLink)
//        print(archiveItem.longLink)
//        print(archiveItem.date)
//        print(archiveItem.iconLink)
//        print(archiveItem.previewLink)

    }

    
    
    
    
    
    ///
    func showControllerShare() {
        let shareController = UIActivityViewController(activityItems: [archiveItem.shortLink as Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                print("it is done!")
            } else {
                print("error send")
            }
        }
        present(shareController, animated: true)
    }
    
    
    
    //
    @IBAction func copyShortLink(_ sender: Any) {
        
    }
    
    //
    @IBAction func copyLongLink(_ sender: Any) {
        
    }
    
    //
    @IBAction func qrCode(_ sender: Any) {
        
    }
    
    //
    @IBAction func shareShortLink(_ sender: Any) {
        if StoreManager.isFullVersion() {
            self.showControllerShare()
        } else {
            if self.interstitial.isReady == true {
                print("ролик готов")
                self.interstitial.present(fromRootViewController: self)
            } else {
                self.showControllerShare()
            }
        }
    }
    
    //
    @IBAction func openLongLink(_ sender: Any) {
        if let url = URL(string: self.archiveItem.longLink) {
            let vc = SafariViewController(url: url, configuration: SFSafariViewController.Configuration())
            self.present(vc, animated: true)
        }
    }
    
    
    
    
    
    
    ///
    @IBAction func closeView (_ sender: UIButton) {
        dismiss(animated: true)
    }
}
