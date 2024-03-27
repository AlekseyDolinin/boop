import UIKit

protocol MainVMDelegate: AnyObject {
    
}

final class MainVM {

    weak var delegate: MainVMDelegate?
    
    var selectedService: Service = .Isgd
    var shortLink: String!
    
    func createShortLink(_ longLink: String) {
        
        
        print("longLink: \(longLink)")
        print("selectedService: \(selectedService)")
        
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
}
