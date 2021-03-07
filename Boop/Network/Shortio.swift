import UIKit
import Alamofire
import SwiftyJSON

extension API {
    class func shortio(longLink: String, completion: @escaping (String) -> Void) {
                
        let userID = "24915583"
        let key = "ff495abeb7228a48a6b118c76efd5adf"
        
        let urlService = "https://api.adf.ly/v1/shorten"
//        let urlService = "http://adf.ly/24915583/\(longLink)"
        
        let parameters = ["url": longLink,
                          "_user_id": userID,
                          "_api_key": key]
        
        Alamofire.request(urlService, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            print(response.response?.statusCode as Any)
            print(response)
            
            
//            let json = JSON(response.value as Any)
//            let resultURL = json["shorturl"].stringValue
//            completion(resultURL)
        }
    }
}
