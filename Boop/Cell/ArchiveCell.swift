import UIKit

class ArchiveCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shortlink: UILabel!
    @IBOutlet weak var longlink: UILabel!
    
    var archiveLink: ArchiveLink!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setCell() {
        setShortLink()
        setLongtLink()
        setDate()
    }
    
    func setShortLink() {
        shortlink.text = archiveLink.shortLink
    }
    
    func setLongtLink() {
        longlink.text = archiveLink.longLink
    }
    
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: archiveLink.date)
    }
}

extension ArchiveCell {
    func setUI() {
        backView.layer.cornerRadius = 8.0
        backView.clipsToBounds = true
    }
}
