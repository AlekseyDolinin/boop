import UIKit

extension MenuNoFullViewController {
    
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
            if StoreManager.isFullVersion() {
                menuCell.titleLabel.text = AppLanguage.dictionary["support"]!.stringValue
                if let priceSupport = UserDefaults.standard.object(forKey: "booplink_support") {
                    menuCell.subLabel.text = "\(priceSupport)"
                }
            } else {
                menuCell.titleLabel.text = AppLanguage.dictionary["getFullVersion"]!.stringValue
                if let priceFullVersion = UserDefaults.standard.object(forKey: "booplink_fullversion") {
                    let textDescription = AppLanguage.dictionary["getFullVersionDescription"]!.stringValue + "(\(priceFullVersion))"
                    menuCell.subLabel.text = textDescription
                }
            }
        case 6:
            menuCell.titleLabel.text = AppLanguage.dictionary["restorePurchase"]!.stringValue
        case 7:
            menuCell.titleLabel.text = AppLanguage.dictionary["support"]!.stringValue
            if let priceSupport = UserDefaults.standard.object(forKey: "booplink_support") {
                menuCell.subLabel.text = "\(priceSupport)"
            }
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
            print("contact")
//            contact()
        case 5:
            viewSelf.showLoader()
            StoreManager.isFullVersion() ? support() : getFullVersion()
        case 6:
            viewSelf.showLoader()
            restorePurchase()
        case 7:
            viewSelf.showLoader()
            support()
        default:
            break
        }
    }
}
