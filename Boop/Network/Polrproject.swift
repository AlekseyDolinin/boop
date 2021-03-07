import UIKit
import Alamofire
import SwiftyJSON

extension API {
    class func polrproject(longLink: String, completion: @escaping (String) -> Void) {
        
        let key = ""
        
        let urlService = "http://polrproject.org/api/v2/action/shorten?key=\(key)&url=\(longLink)"
        
        Alamofire.request(urlService, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            print(response.response?.statusCode)
            print(response)
            
            
            let json = JSON(response.value as Any)
            let resultURL = json["shorturl"].stringValue
            completion(resultURL)
        }
    }
}
