import UIKit
import SwiftLinkPreview
import Kingfisher
import FaviconFinder

class ArchiveCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shortlink: UILabel!
    @IBOutlet weak var longlink: UILabel!
    @IBOutlet weak var favicon: UIImageView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var archiveItem: ArchiveItem!
    let slp = SwiftLinkPreview(session: URLSession.shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
    
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
        setPreview()
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
    
    func getFavicon() {
        guard let url: URL = URL(string: archiveItem.iconLink ?? "") else {
            print("error url iconLink")
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
    
    ///
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: archiveItem.date)
    }
    
    ///
    func setPreview() {
        guard let url: URL = URL(string: archiveItem.previewLink ?? "") else {
            print("error url previewLink")
            imagePreview.isHidden = true
            topConstraint.constant = 16
            return
        }
        LoadImage.get(urlImage: url) { image in
            self.imagePreview.image = image
        }
    }
}

extension ArchiveCell {
    func setUI() {
        backView.layer.cornerRadius = 8.0
        backView.clipsToBounds = true
    }
}
