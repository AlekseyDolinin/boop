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
    //    @IBOutlet weak var imagePreview: UIImageView!
    //    @IBOutlet weak var loader: UIActivityIndicatorView!
    
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
        parseHTML()
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
    
    
    func parseHTML() {
        let slp = SwiftLinkPreview(session: URLSession.shared,
                                   workQueue: SwiftLinkPreview.defaultWorkQueue,
                                   responseQueue: DispatchQueue.main,
                                   cache: DisabledCache.instance)
        slp.preview(archiveItem.longLink,
                    onError: { error in
            print("Error: \(error)")},
                    onSuccess: { result in
            print("canonicalUrl:\(result.canonicalUrl)")
            print("finalUrl:\(result.finalUrl)")
            print("description:\(result.description)")
            print("url:\(result.url)")
            print("title:\(result.title)")
            print("favicon:\(result.icon)")
            print("imagePreview:\(result.image)")
        })
    }
}

extension ArchiveCell {
    func setUI() {
        backView.layer.cornerRadius = 8.0
        backView.clipsToBounds = true
        backView.backgroundColor = .clear
    }
}

import UIKit
import Foundation

class loadImage {
    class func get(urlImage: URL, completion: @escaping (UIImage?) -> ()) {
        UIImageView().kf.setImage(with: urlImage,
                                  placeholder: UIImage(named: ""),
                                  options: [ .scaleFactor(UIScreen.main.scale),
                                             .transition(.fade(0.2)),
                                             .cacheOriginalImage]) { receivedSize, totalSize in
        } completionHandler: { image, error, cacheType, imageURL in
            if error != nil {
                print("ERROR GET IMAGE: \(String(describing: error))")
                print("ERROR LINK: \(String(describing: imageURL))")
                completion (UIImage(named: "logo_frame"))
            } else {
                completion (image)
            }
        }
    }
}
