import UIKit
import GoogleMobileAds
import Foundation
import GoogleMobileAds

class ArchiveViewController: UIViewController, GADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, GADInterstitialDelegate {
    
    var viewSelf: ArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! ArchiveView)
    }
    
    var arrayArchive = [ArchiveItem]()
    var bannerView: GADBannerView!
    let pasteboard = UIPasteboard.general
    var interstitial: GADInterstitial!
    var shortLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        viewSelf.archiveTable.delegate = self
        viewSelf.archiveTable.dataSource = self
        setGadBanner()
        setGadFullView()
        setupLongPressGesture()
        
        ParseArhive.parse(completion: { array in
            self.viewSelf.emptyLabel.isHidden = array.isEmpty ? false : true
            self.arrayArchive = array.isEmpty ? [] : array
        })
    }
    
    ///
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: viewSelf.archiveTable)
            if let indexPath = viewSelf.archiveTable.indexPathForRow(at: touchPoint) {
                copyToClipboardShortLink(index: indexPath.row)
            }
        }
    }
    
    ///
    func copyToClipboardShortLink(index: Int) {
        pasteboard.string = arrayArchive[index].shortLink
        showAlertCopy()
    }

    ///
    func copyToClipboardLongLink(index: Int) {
        pasteboard.string = arrayArchive[index].longLink
        showAlertCopy()
    }
    
    ///
    func showAlertCopy() {
        let alert = UIAlertController(title: nil, message: "Link copied", preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.dismiss(animated: true)
        }
    }
    
    ///
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        viewSelf.archiveTable.addGestureRecognizer(longPressGesture)
    }
    
    ///
    func showControllerShare() {
        let shareController = UIActivityViewController(activityItems: [self.shortLink as Any], applicationActivities: nil)
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
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
