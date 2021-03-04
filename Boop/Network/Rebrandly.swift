import UIKit
import Alamofire

extension API {
    class func rebrandly(longLink: String, completion: @escaping (String) -> Void) {
        
        let urlService = "https://api.rebrandly.com/v1/links"
        
        let headers = [
            "Content-Type": "application/json",
            "apikey": "034793fd86bc414abba5df8338d246c6"
        ]
        
        let parameters = ["destination": longLink, "fullName": "rebrand.ly"]
        
        Alamofire.request(urlService, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { responseJSON in
            do {
                if let json = try JSONSerialization.jsonObject(with: responseJSON.data ?? Data(), options: []) as? [String: Any] {
                    if let resultURL = json["shortUrl"] {
                        completion(resultURL as! String)
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
}
