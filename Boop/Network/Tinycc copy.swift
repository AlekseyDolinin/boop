import UIKit
import Alamofire

extension API {
    class func tinycc(longLink: String, completion: @escaping (String) -> Void) {
        
        let key = "60252b2e-1225-4e1d-a55a-de8434924ca4"
        
        let urlService = "https://tinycc.com/tiny/api/3/"
        
        let headers = [
            "Authorization": "Basic \(key)",
            "Content-Type": "application/json",
            "Content-Length": "message.length"
        ]
        
        let parameters = ["custom_hash": "mytiny",
                          "long_url": longLink,
                          "note": "lots of notes...",
                          "email_stats": false,
                          "expiration_date": "2030-01-02",
                          "tags": ["group1"]] as [String : Any]
        
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
