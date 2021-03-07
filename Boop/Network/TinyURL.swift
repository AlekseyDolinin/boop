import UIKit
import Alamofire

extension API {
    class func tinyURL(longLink: String, completion: @escaping (String) -> Void) {
        
        let key = "Il4NIlgbbpJfcrVb6PW3ImCsVapiW0zyJQredPXwTNpwVRa37CQg9FGXiQ3q"
        
        let urlService = "https://tiny-url.info/api/v1/create"
        
//        let parameters = ["apikey": key,
//                          "provider": "tiny_cc",
//                          "format": "json",
//                          "url": longLink]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(key.data(using: .utf8)!, withName: "apikey")
                multipartFormData.append("doo_ly".data(using: .utf8)!, withName: "provider")
                multipartFormData.append("json".data(using: .utf8)!, withName: "format")
                multipartFormData.append(longLink.data(using: .utf8)!, withName: "url")
                
        }, to: urlService, method: .post) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response)
//                    let value = response.value as! [String: String]
//                    let shortLink = value["result_url"]
//                    completion(shortLink ?? "error")
                }
                
            case .failure( _): break
            }
        }
    }
}
