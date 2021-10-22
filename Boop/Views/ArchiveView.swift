import UIKit

class ArchiveView: UIView {
    
    @IBOutlet weak var archiveTable: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    
    override func awakeFromNib() {

        setUI()
        
    }
    
    
    func configure() {

    }
}

extension ArchiveView {
    
    func setUI() {
        emptyLabel.isHidden = true
    }
}
