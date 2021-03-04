import UIKit

class API {
    
    /// выбоор сервиса
    /// в serviceName приходит имя выбраного сервиса
    class func post(serviceName: String, inputLongLink: String, completion: @escaping (String) -> Void) {
        
        switch serviceName {
        case "urlShortenerService":
            urlShortenerService(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "1":
            print("1")
        case "2":
            print("2")
        default:
            break
        }
    }
}
