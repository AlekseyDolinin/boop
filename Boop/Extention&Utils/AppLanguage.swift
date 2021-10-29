import UIKit
import SwiftyJSON

class AppLanguage {
    
    enum Lang: String {
        case Russia = "Russia"
        case Usa = "Usa"
        case Brazil = "Brazil"
        case Vietnam = "Vietnam"
    }
    
    static var selectLanguage: Lang!
    static var dictionary = [String : JSON]()
    
    class func setLanguage() {
        let tagSelectLanguage = UserDefaults.standard.integer(forKey: "TagSelectLanguage")
        switch tagSelectLanguage {
        case 1:
            selectLanguage = .Usa
        case 2:
            selectLanguage = .Russia
        case 3:
            selectLanguage = .Brazil
        case 4:
            selectLanguage = .Vietnam
        default:
            print("default language")
            selectLanguage = .Usa
        }
        
        setDictionary()
    }
    
    ///
    class func setDictionary() {
        if let path = Bundle.main.path(forResource: AppLanguage.selectLanguage.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data: data)
                dictionary = json.dictionary!
            } catch {
                print("ERROR GET JSON LANGUAGE")
            }
        }
    }
}
