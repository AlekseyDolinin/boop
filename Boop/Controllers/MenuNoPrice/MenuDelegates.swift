import UIKit

extension MenuNoPriceViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        menuCell.subLabel.isHidden = indexPath.row == 0 ? false : true
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
        default:
            break
        }
    }
}
