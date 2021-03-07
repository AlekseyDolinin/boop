import UIKit
import Alamofire

extension API {
    class func bitly(longLink: String, completion: @escaping (String) -> Void) {
        
        let key = "o_5sd301cgum"
        
        let urlService = "https://api-ssl.bitly.com/v4/shorten"
        
        let headers = [
            "Authorization": "Bearer {\(key)}",
            "Content-Type": "application/json"
        ]
        
        let parameters = ["long_url": longLink, "domain": "bit.ly", "group_guid": "Ba1bc23dE4F"]
        
        Alamofire.request(urlService, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { responseJSON in
            
            print(responseJSON)
            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: responseJSON.data ?? Data(), options: []) as? [String: Any] {
//                    if let resultURL = json["shortUrl"] {
//                        completion(resultURL as! String)
//                    }
//                }
//            } catch let error as NSError {
//                print("Failed to load: \(error.localizedDescription)")
//            }
        }
        

    }
}
