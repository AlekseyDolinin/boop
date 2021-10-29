import UIKit

class ArchiveMenuCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(AppLanguage.selectLanguage)
        titleLabel.text = AppLanguage.dictionary["arhiveURL"]!.stringValue
    }
}

class SettingsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class RateCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class ShareCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class RemoveADMenuCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleOne: UILabel!
    @IBOutlet weak var subTitleTwo: UILabel!
}

class PurchaseCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class RewardCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}
