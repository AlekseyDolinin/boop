import UIKit

extension MenuViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        switch indexPath.row {
        case 0:
            menuCell.titleLabel.text = AppLanguage.dictionary["arhive"]!.stringValue
            menuCell.subTitleOne.isHidden = false
            menuCell.subTitleTwo.isHidden = true
        case 1:
            menuCell.titleLabel.text = AppLanguage.dictionary["settings"]!.stringValue
            menuCell.subTitleOne.isHidden = true
            menuCell.subTitleTwo.isHidden = true
        case 2:
            menuCell.titleLabel.text = AppLanguage.dictionary["rateAndFeedback"]!.stringValue
            menuCell.subTitleOne.isHidden = true
            menuCell.subTitleTwo.isHidden = true
        case 3:
            menuCell.titleLabel.text = AppLanguage.dictionary["shareThisApp"]!.stringValue
            menuCell.subTitleOne.isHidden = true
            menuCell.subTitleTwo.isHidden = true
        case 4:
            menuCell.titleLabel.text = AppLanguage.dictionary["contactAuthor"]!.stringValue
            menuCell.subTitleOne.isHidden = true
            menuCell.subTitleTwo.isHidden = true
        case 5:
            menuCell.titleLabel.text = AppLanguage.dictionary["getFullVersion"]!.stringValue
            menuCell.subTitleOne.isHidden = false
            menuCell.subTitleTwo.isHidden = false
            menuCell.subTitleOne.text = AppLanguage.dictionary["getFullVersionSubOne"]!.stringValue
            menuCell.subTitleTwo.text = AppLanguage.dictionary["getFullVersionSubTwo"]!.stringValue
        case 6:
            menuCell.titleLabel.text = AppLanguage.dictionary["resumePurchase"]!.stringValue
            menuCell.subTitleOne.isHidden = true
            menuCell.subTitleTwo.isHidden = true
        case 7:
            menuCell.titleLabel.text = AppLanguage.dictionary["reward"]!.stringValue
            menuCell.subTitleOne.isHidden = false
            menuCell.subTitleTwo.isHidden = true
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
