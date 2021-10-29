import UIKit
import GoogleMobileAds
import Foundation
import GoogleMobileAds

class ArchiveViewController: UIViewController, GADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, GADInterstitialDelegate {
    
    var viewSelf: ArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! ArchiveView)
    }
    
    var arrayArchive = [ArchiveLink]()
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
        
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                arrayArchive = try decoder.decode([ArchiveLink].self, from: data)
                viewSelf.emptyLabel.isHidden = arrayArchive.isEmpty ? false : true
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        } else {
            viewSelf.emptyLabel.isHidden = false
        }
    }
    
    ///
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: viewSelf.archiveTable)
            if let indexPath = viewSelf.archiveTable.indexPathForRow(at: touchPoint) {
                copyToClipboard(index: indexPath.row)
            }
        }
    }
    
    ///
    func copyToClipboard(index: Int) {
        pasteboard.string = arrayArchive[index].shortLink
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
