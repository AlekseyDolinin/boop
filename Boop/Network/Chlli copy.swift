//import UIKit
//import Alamofire
//import SwiftyJSON
//
//extension API {
//    class func chlli(longLink: String, completion: @escaping (String) -> Void) {
//        
//        let urlService = "https://chl.li/api/v1/shorten?url=\(longLink)"
//        let headers = ["Accept": "application/json"]
//        Alamofire.request(urlService, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//            
//            print(response)
//            
//            let json = JSON(response.value as Any)
//            let resultURL = json["url"].stringValue
//            completion(resultURL)
//        }
//    }
//}
