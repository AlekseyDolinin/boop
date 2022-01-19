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
    let pasteboard = UIPasteboard.general
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSelf.archiveItemTable.delegate = self
        viewSelf.archiveItemTable.dataSource = self
        
        viewSelf.archiveItem = self.archiveItem
        viewSelf.configure()
        
        if StoreManager.isFullVersion() == false {
            setGadFullView()
        }
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
    
    ///
    func showAlertCopy() {
        let alert = UIAlertController(title: nil, message: AppLanguage.dictionary["linkCopied"]!.stringValue, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true)
        }
    }
    
    //
    @IBAction func copyShortLink(_ sender: Any) {
        pasteboard.string = archiveItem.shortLink
        showAlertCopy()
    }
    
    //
    @IBAction func copyLongLink(_ sender: Any) {
        pasteboard.string = archiveItem.longLink
        showAlertCopy()
    }
    
    //
    @IBAction func qrCode(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
        vc.linkForQRCode = archiveItem.shortLink
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
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
