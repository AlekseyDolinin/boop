import UIKit

protocol MainVMDelegate: AnyObject {
    
}

final class MainVM {

    weak var delegate: MainVMDelegate?
    
    var selectedService: Service = .Isgd
    var shortLink: String!
    
    func createShortLink(_ longLink: String) {
        print("createShortLink")
        
        Task(priority: .userInitiated) {
            switch selectedService {
            case .Isgd:
                print("Isgd")
                await isgd(longLink: longLink)
            default:
                break
            }
            print("shortLink: \(shortLink)")
        }

        
        
        
//        API.selectService(longLink, service: Service.allCases[currentIndexService]) { (shortLink) in
//
//            print("shortLink: \(shortLink)")
//
////            self.viewSelf.placeLinkButton.isUserInteractionEnabled = true
////            DispatchQueue.main.async {
////                if responseShortLink != "" {
////                    self.showResult(resutShortUrl: responseShortLink)
////                } else {
////                    self.viewSelf.showMessage(text: AppLanguage.dictionary["errorMsg"]!.stringValue)
////                }
////            }
//        }
    }
    
    
    private func isgd(longLink: String) async {
        print("isgd")
        let urlService = "https://is.gd/create.php?format=json&url=\(longLink)"
        let json = await API.shared._request(urlService, method: .get)
        if let json = json {
            print(json)
            shortLink = json["shorturl"].stringValue
        }
    }
}
