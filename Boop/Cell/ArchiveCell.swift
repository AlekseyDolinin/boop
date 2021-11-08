import UIKit
import FaviconFinder

class ArchiveCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shortlink: UILabel!
    @IBOutlet weak var longlink: UILabel!
    @IBOutlet weak var favicon: UIImageView!
    
    var archiveItem: ArchiveItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setCell() {
        setShortLink()
        setLongtLink()
        setDate()
        setName()
        getFavicon()
    }
    
    func setName() {
        name.text = archiveItem.name
    }
    
    func setShortLink() {
        shortlink.text = archiveItem.shortLink
    }
    
    func setLongtLink() {
        longlink.text = archiveItem.longLink
    }
    
    ///
    func getFavicon() {
        guard let url: URL = URL(string: archiveItem.longLink) else {return}
        FaviconFinder(url: url).downloadFavicon { result in
            switch result {
            case .success(let favicon):
                DispatchQueue.main.async {
                    self.favicon.image = favicon.image
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: archiveItem.date)
    }
}

extension ArchiveCell {
    func setUI() {
        backView.layer.cornerRadius = 8.0
        backView.clipsToBounds = true
    }
}
