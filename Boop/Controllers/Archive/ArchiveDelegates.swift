import UIKit
import SafariServices

extension ArchiveViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrayArchive.count)
        return arrayArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let archiveCell = tableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath) as! ArchiveCell
        archiveCell.archiveLink = arrayArchive[indexPath.row]
        archiveCell.setCell()
        return archiveCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionCopy = UIAlertAction(title: "Copy short link to clipboard", style: .default) { action in
            self.copyToClipboard(index: indexPath.row)
        }
        
        let actionQR = UIAlertAction(title: "QR code", style: .default) { action in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
            vc.linkForQRCode = self.arrayArchive[indexPath.row].shortLink
            vc.modalPresentationStyle = .formSheet
            self.present(vc, animated: true)
        }
        
        let actionOpenLink = UIAlertAction(title: "Open link", style: .default) { action in
            if let url = URL(string: self.arrayArchive[indexPath.row].longLink) {
                let vc = SafariViewController(url: url, configuration: SFSafariViewController.Configuration())
                self.present(vc, animated: true)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        
        actionSheet.addAction(actionCopy)
        actionSheet.addAction(actionQR)
        actionSheet.addAction(actionOpenLink)
        actionSheet.addAction(actionCancel)
        present(actionSheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayArchive.remove(at: indexPath.row)
            viewSelf.archiveTable.reloadData()
            /// запись нового массива
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(arrayArchive)
                UserDefaults.standard.set(data, forKey: "arrayArchive")
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
    }
}
