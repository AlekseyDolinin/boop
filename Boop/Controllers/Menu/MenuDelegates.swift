import UIKit

extension MenuViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "ArchiveMenuCell", for: indexPath) as! ArchiveMenuCell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "RateCell", for: indexPath) as! RateCell
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: "ShareCell", for: indexPath) as! ShareCell
        case 4:
            return tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath) as! Contact
        case 5:
            return tableView.dequeueReusableCell(withIdentifier: "RemoveADMenuCell", for: indexPath) as! RemoveADMenuCell
        case 6:
            return tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as! PurchaseCell
        case 7:
            return tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openArchive()
        case 1:
            openSettings()
        case 2:
            openAppStore()
        case 3:
            shareThisApp()
        case 4:
            contact()
        case 5:
            removeAD()
        case 6:
            resumePurchase()
        case 7:
            reward()
        default:
            break
        }
    }
}
