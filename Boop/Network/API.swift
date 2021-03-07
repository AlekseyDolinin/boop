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
        case "rebrandly":
            rebrandly(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "tinyURL":
            tinyURL(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "bitly":
            bitly(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "tinycc":
            tinycc(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "chlli":
            chlli(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "isgd":
            isgd(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "polrproject":
            polrproject(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "adfly":
            adfly(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case "shortio":
            shortio(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        default:
            break
        }
    }
}
