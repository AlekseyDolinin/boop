import UIKit
import Alamofire
import SwiftyJSON

extension API {
    class func tinyURL(longLink: String, completion: @escaping (String) -> Void) {
        
        let key = "jN5rKoyNJkWLH2ZZdWXcxT5z0BWegD75Q8ezIWkapnKRz5PXBGd1SaAWlmp7"
        
        let urlService = "https://api.tinyurl.com/create"
        
        let headers = ["Authorization": "Bearer \(key)"]
        
        let parameters: [String : Any] = ["url": "\(longLink)",
                                          "domain": "tiny.one",
                                          "alias": "",
                                          "tags": ""]
        
        Alamofire.request(urlService, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            let json = JSON(response.value as Any)
            let resultURL = json["data"]["tiny_url"].stringValue
            completion(resultURL)
        }
    }
}
