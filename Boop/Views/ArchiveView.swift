import UIKit

class ArchiveView: UIView {
    
    @IBOutlet weak var archiveTable: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func awakeFromNib() {
        setUI()
    }
}

extension ArchiveView {
    ///
    func setUI() {
        setLabels()
        ///
        backButton.setImage(UIImage(named: "backArrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        
        ///
        emptyLabel.isHidden = true
    }
    ///
    func setLabels() {
        emptyLabel.text = AppLanguage.dictionary["archiveIsEmpty"]!.stringValue
    }
}
