import UIKit

extension API {
    class func urlShortenerService(longLink: String, completion: @escaping (String) -> Void) {
        let urlService = "https://url-shortener-service.p.rapidapi.com/shorten"
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "x-rapidapi-key": "15d2e6dcebmsh64156bb3423fc08p193afejsn6472465d2a74",
            "x-rapidapi-host": "url-shortener-service.p.rapidapi.com"
        ]
        let postData: Data = "url=\(longLink)".data(using: String.Encoding.utf8) ?? Data()
        var request = URLRequest(url: NSURL(string: urlService)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                if let data = data {
                    JSON.serialization(data: data, completion: { (shortLink) in
                        completion(shortLink)
                    })
                }
            }
        })
        dataTask.resume()
    }
}
