import UIKit
import Alamofire
import SwiftyJSON

extension API {
    class func tinyURL(longLink: String, completion: @escaping (String) -> Void) {
        
        let key = "eGyT4JtIFWt5e1q3U3qCP7ptKnmjL1ToYCur2vYeGgvDb595GqumMJtF7Xj5"
        
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
