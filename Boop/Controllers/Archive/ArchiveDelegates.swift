import UIKit
import SafariServices
import GoogleMobileAds

extension ArchiveViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let archiveCell = tableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath) as! ArchiveCell
        archiveCell.archiveItem = arrayArchive[indexPath.row]
        archiveCell.setCell()
        return archiveCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.shortLink = self.arrayArchive[indexPath.row].shortLink
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let actionCopyShortLink = UIAlertAction(title: "Copy short link", style: .default) { action in
            self.copyToClipboardShortLink(index: indexPath.row)
        }

        let actionCopyLongLink = UIAlertAction(title: "Copy long link", style: .default) { action in
            self.copyToClipboardLongLink(index: indexPath.row)
        }
        let actionQR = UIAlertAction(title: "QR code", style: .default) { action in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
            vc.linkForQRCode = self.shortLink
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true)
        }
        
        let actionShareLink = UIAlertAction(title: "Share link", style: .default) { action in
            if self.interstitial.isReady == true {
                print("ролик готов")
                self.interstitial.present(fromRootViewController: self)
            } else {
                self.showControllerShare()
            }
        }
        
        let actionOpenLink = UIAlertAction(title: "Open link", style: .default) { action in
            if let url = URL(string: self.arrayArchive[indexPath.row].longLink) {
                let vc = SafariViewController(url: url, configuration: SFSafariViewController.Configuration())
                self.present(vc, animated: true)
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { action in }
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            self.arrayArchive.remove(at: indexPath.row)
            self.viewSelf.archiveTable.reloadData()
            /// запись нового массива
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(self.arrayArchive)
                UserDefaults.standard.set(data, forKey: "arrayArchive")
            } catch {
                print("Unable to Encode Note (\(error))")
            }
            completion(true)
        }
        deleteAction.image = UIImage(named: "trash.png")
        deleteAction.backgroundColor = .Violet_Dark_
        return UISwipeActionsConfiguration(actions: [deleteAction/*, muteAction*/])
    }
}
