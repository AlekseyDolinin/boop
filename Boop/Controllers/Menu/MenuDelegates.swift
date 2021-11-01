import UIKit

extension MenuViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        if indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 7 {
            menuCell.subLabel.isHidden = false
        } else {
            menuCell.subLabel.isHidden = true
        }
        
        switch indexPath.row {
        case 0:
            menuCell.titleLabel.text = AppLanguage.dictionary["arhive"]!.stringValue
            setDescriptionArchive { text in
                menuCell.subLabel.text = text
            }
        case 1:
            menuCell.titleLabel.text = AppLanguage.dictionary["settings"]!.stringValue
        case 2:
            menuCell.titleLabel.text = AppLanguage.dictionary["rateAndFeedback"]!.stringValue
        case 3:
            menuCell.titleLabel.text = AppLanguage.dictionary["shareThisApp"]!.stringValue
        case 4:
            menuCell.titleLabel.text = AppLanguage.dictionary["contactAuthor"]!.stringValue
        case 5:
            menuCell.titleLabel.text = AppLanguage.dictionary["getFullVersion"]!.stringValue
            menuCell.subLabel.text = AppLanguage.dictionary["getFullVersionDescription"]!.stringValue
        case 6:
            menuCell.titleLabel.text = AppLanguage.dictionary["restorePurchase"]!.stringValue
        case 7:
            menuCell.titleLabel.text = AppLanguage.dictionary["reward"]!.stringValue
            menuCell.subLabel.text = AppLanguage.dictionary["rewardDescription"]!.stringValue
        default:
            break
        }
        return menuCell
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
