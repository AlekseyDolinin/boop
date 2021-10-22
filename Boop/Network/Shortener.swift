import UIKit
import Alamofire

extension API {
    class func urlShortenerService(longLink: String, completion: @escaping (String) -> ()) {
        let urlService = "https://url-shortener-service.p.rapidapi.com/shorten"
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "x-rapidapi-key": "15d2e6dcebmsh64156bb3423fc08p193afejsn6472465d2a74",
            "x-rapidapi-host": "url-shortener-service.p.rapidapi.com"
        ]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
               multipartFormData.append(longLink.data(using: .utf8)!, withName: "url")
        }, to: urlService, method: .post, headers: headers) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    let value = response.value as! [String: String]
                    value.keys.first == "error" ? completion("") : completion(value["result_url"] ?? "")
                }
            case .failure( _): break
            }
        }
    }
}
