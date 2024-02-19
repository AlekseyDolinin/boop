import UIKit
import Foundation

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewSelf: ArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! ArchiveView)
    }
    
    var arrayArchive = [ArchiveItem]()
    let pasteboard = UIPasteboard.general
    var shortLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.archiveTable.delegate = self
        viewSelf.archiveTable.dataSource = self
        
        Archive.parse(completion: { array in
            self.viewSelf.emptyLabel.isHidden = array.isEmpty ? false : true
            self.arrayArchive = array.isEmpty ? [] : array
        })
//        
//        if StoreManager.isFullVersion() == false {
//            setGadBanner()
//            setGadFullView()
//        }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true)
        }
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
