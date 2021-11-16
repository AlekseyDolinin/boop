import UIKit
import SwiftLinkPreview
import Kingfisher
import FaviconFinder

import WebLinkPreview
import SwiftLinkPreview

class ArchiveCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shortlink: UILabel!
    @IBOutlet weak var longlink: UILabel!
    @IBOutlet weak var favicon: UIImageView!
    @IBOutlet weak var imagePreview: UIImageView!
    //    @IBOutlet weak var loader: UIActivityIndicatorView!
    
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
//        parseHTML()
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
        
//        _ = WebLinkMetadata(url: url) { webLinkMetadata, error in
//            guard let webLinkMetadata = webLinkMetadata else {
//                return // Handle error.
//            }
//
//            print("content: \(webLinkMetadata.content)")
//            print("iconURL: \(webLinkMetadata.iconURL)")
//            print("themeUIColor: \(webLinkMetadata.themeUIColor)")
//            print("image: \(webLinkMetadata["image"])")
//            print("image_: \(webLinkMetadata[.image])")
//
//            print(webLinkMetadata.iconLink)
//            print(webLinkMetadata.openGraph)
//
//            webLinkMetadata.content // enum [.html, .image(URL), .video(URL), .other(URL)]
//            webLinkMetadata.iconURL // URL for largest sized <link rel="icon" ...>
//            webLinkMetadata.themeUIColor // UIColor for <meta name="theme-color" ...>
//            webLinkMetadata["image"] // String for <meta property="og:image" ...>
//            webLinkMetadata[.image] // OpenGraph enum for above
//            // Any UI operations should be performed on main thread.
//        }
        
        
        
        let preview = slp.preview(archiveItem.longLink,
                                  onError: {
            error in print("\(error)") },
                                  onSuccess: {
            result in print("\(result)")
            print(result.icon)
            print(result.image)
            print(result.title)
            
            self.name.text = result.title
            guard let url = URL(string: result.image ?? "") else {
                print("___")
                return
            }
            LoadImage.get(urlImage: url) { image in
                self.imagePreview.image = image
            }
            
        })
    }
    
    ///
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: archiveItem.date)
    }
    
    
//    func parseHTML() {
//        let slp = SwiftLinkPreview(session: URLSession.shared,
//                                   workQueue: SwiftLinkPreview.defaultWorkQueue,
//                                   responseQueue: DispatchQueue.main,
//                                   cache: DisabledCache.instance)
//        slp.preview(archiveItem.longLink,
//                    onError: { error in
//            print("Error: \(error)")},
//                    onSuccess: { result in
//            print("canonicalUrl:\(result.canonicalUrl)")
//            print("finalUrl:\(result.finalUrl)")
//            print("description:\(result.description)")
//            print("url:\(result.url)")
//            print("title:\(result.title)")
//            print("favicon:\(result.icon)")
//            print("imagePreview:\(result.image)")
//        })
//    }
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

class LoadImage {
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
