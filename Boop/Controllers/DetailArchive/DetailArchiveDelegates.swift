import UIKit
import SafariServices
import GoogleMobileAds

extension DetailArchiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if StoreManager.isFullVersion() {
            let archiveDetailCellFullVersion = tableView.dequeueReusableCell(withIdentifier: "ArchiveDetailCellFullVersion", for: indexPath) as! ArchiveDetailCellFullVersion
            archiveDetailCellFullVersion.archiveItem = self.archiveItem
            archiveDetailCellFullVersion.setCell()
            return archiveDetailCellFullVersion
        } else {
            let archiveDetailCell = tableView.dequeueReusableCell(withIdentifier: "ArchiveDetailCell", for: indexPath) as! ArchiveDetailCell
            archiveDetailCell.archiveItem = self.archiveItem
            archiveDetailCell.setCell()
            return archiveDetailCell
        }
    }
    
}
