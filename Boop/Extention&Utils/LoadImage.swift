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
