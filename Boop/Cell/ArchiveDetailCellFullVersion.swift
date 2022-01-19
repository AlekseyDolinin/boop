import UIKit
import SwiftLinkPreview
import FaviconFinder

class ArchiveDetailCellFullVersion: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shortlink: UILabel!
    @IBOutlet weak var longlink: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
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
        setDescription()
    }
    
    func getFavicon() {
        guard let url: URL = URL(string: archiveItem.iconLink ?? "") else {
            #if DEBUG
            print("error url iconLink")
            #endif
            getFaviconAlternative()
            return
        }
        LoadImage.get(urlImage: url) { image in
            self.favicon.image = image
        }
    }
    
    ///
    func getFaviconAlternative() {
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
    
    func setDescription() {
        descriptionLabel.text = archiveItem.description
    }
    
    func setShortLink() {
        shortlink.text = archiveItem.shortLink
    }
    
    func setName() {
        name.text = archiveItem.name
    }
    
    func setLongtLink() {
        longlink.text = archiveItem.longLink
    }
    
    ///
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: archiveItem.date)
    }
}

extension ArchiveDetailCellFullVersion {
    func setUI() {

    }
}
