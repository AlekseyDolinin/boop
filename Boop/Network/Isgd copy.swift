import UIKit
import Alamofire
import SwiftyJSON

extension API {
    class func isgd(longLink: String, completion: @escaping (String) -> ()) {
        
        let urlService = "https://is.gd/create.php?format=json&url=\(longLink)"
        
        Alamofire.request(urlService, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            let json = JSON(response.value as Any)
            let resultURL = json["shorturl"].stringValue
            completion(resultURL)
        }
    }
}
