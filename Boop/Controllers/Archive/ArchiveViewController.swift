import UIKit
import Foundation
import SafariServices

class ArchiveViewController: UIViewController {
    
    var arrayArchive = [ArchiveItem]()
    let pasteboard = UIPasteboard.general
    var shortLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewSelf.archiveTable.delegate = self
//        viewSelf.archiveTable.dataSource = self
//        
//        Archive.parse(completion: { array in
//            self.viewSelf.emptyLabel.isHidden = array.isEmpty ? false : true
//            self.arrayArchive = array.isEmpty ? [] : array
//        })
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


extension ArchiveViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
//        let archiveCell = tableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath) as! ArchiveCell
//        let archiveCellFullVersion = tableView.dequeueReusableCell(withIdentifier: "ArchiveCellFullVersion", for: indexPath) as! ArchiveCellFullVersion
//        archiveCell.archiveItem = arrayArchive[indexPath.row]
//        archiveCell.setCell()
//        archiveCellFullVersion.archiveItem = arrayArchive[indexPath.row]
//        archiveCellFullVersion.setCell()
//        return StoreManager.isFullVersion() ? archiveCellFullVersion : archiveCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.shortLink = self.arrayArchive[indexPath.row].shortLink
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let copyShortLink = AppLanguage.dictionary["copyShortLink"]!.stringValue
        let actionCopyShortLink = UIAlertAction(title: copyShortLink, style: .default) { action in
            self.copyToClipboardShortLink(index: indexPath.row)
        }

        let copyLongLink = AppLanguage.dictionary["copyLongLink"]!.stringValue
        let actionCopyLongLink = UIAlertAction(title: copyLongLink, style: .default) { action in
            self.copyToClipboardLongLink(index: indexPath.row)
        }
        
        let qrCode = AppLanguage.dictionary["qrCode"]!.stringValue
        let actionQR = UIAlertAction(title: qrCode, style: .default) { action in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
            vc.linkForQRCode = self.shortLink
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true)
        }
        
        let shareShortLink = AppLanguage.dictionary["shareShortLink"]!.stringValue
        let actionShareLink = UIAlertAction(title: shareShortLink, style: .default) { action in
            self.showControllerShare()
        }
        
        let openLongLink = AppLanguage.dictionary["openLongLink"]!.stringValue
        let actionOpenLink = UIAlertAction(title: openLongLink, style: .default) { action in
            if let url = URL(string: self.arrayArchive[indexPath.row].longLink) {
                let vc = SafariViewController(url: url, configuration: SFSafariViewController.Configuration())
                self.present(vc, animated: true)
            }
        }
        
        let titleCancel = AppLanguage.dictionary["cancel"]!.stringValue
        let actionCancel = UIAlertAction(title: titleCancel, style: .cancel) { action in }
        actionSheet.addAction(actionCopyShortLink)
        actionSheet.addAction(actionCopyLongLink)
        actionSheet.addAction(actionQR)
        actionSheet.addAction(actionShareLink)
        actionSheet.addAction(actionOpenLink)
        actionSheet.addAction(actionCancel)
        present(actionSheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
//            self.arrayArchive.remove(at: indexPath.row)
//            self.viewSelf.archiveTable.reloadData()
//            /// запись нового массива
//            do {
//                let encoder = JSONEncoder()
//                let data = try encoder.encode(self.arrayArchive)
//                UserDefaults.standard.set(data, forKey: "arrayArchive")
//            } catch {
//                print("Unable to Encode Note (\(error))")
//            }
//            completion(true)
//        }
//        deleteAction.image = UIImage(named: "trash.png")
//        deleteAction.backgroundColor = .Violet_Dark_
//        return UISwipeActionsConfiguration(actions: [deleteAction/*, muteAction*/])
//    }
}
