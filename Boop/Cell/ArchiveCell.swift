import UIKit

class ArchiveCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shortlink: UILabel!
    @IBOutlet weak var longlink: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        
    }
}

extension ArchiveCell {
    func setUI() {
        backView.layer.cornerRadius = 8.0
        backView.clipsToBounds = true
    }
}
