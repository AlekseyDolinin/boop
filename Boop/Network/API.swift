import UIKit

class API {
    
    /// выбоор сервиса
    /// в serviceName приходит имя выбраного сервиса
    class func post(inputLongLink: String, completion: @escaping (String) -> Void) {
        
        switch StartViewController.selectedService {
            
        case .Isgd:
            isgd(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
            
        case .Shortener:
            urlShortenerService(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
            
        case .TinyURL:
            tinyURL(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }

        case .Click:
            click(longLink: inputLongLink) { (outShortLink) in
                completion(outShortLink)
            }
        }
    }
}
