import UIKit
import Alamofire
import SwiftyJSON

extension API {
    class func click(longLink: String, completion: @escaping (String) -> Void) {
        
        let urlService = "https://clck.ru/--?url=\(longLink)"
        
        Alamofire.request(urlService, method: .get).response { response in
            
            if let data = response.data {
                let resultURL = String(decoding: data, as: UTF8.self)
                completion(resultURL)
            }
        }
    }
}
