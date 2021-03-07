import UIKit

class API {
    
    /// выбоор сервиса
    /// в serviceName приходит имя выбраного сервиса
    class func post(inputLongLink: String, completion: @escaping (String) -> Void) {
        
        let serviceKey = StartViewController.selectedService
        
        switch serviceKey {
        case .Shortener:
            urlShortenerService(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Rebrandly:
            rebrandly(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .TinyURL:
            tinyURL(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Bitly:
            bitly(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Tinycc:
            tinycc(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Chlli:
            chlli(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Isgd:
            isgd(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Polrproject:
            polrproject(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Adfly:
            adfly(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        case .Shortio:
            shortio(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        }
    }
}
