import UIKit

class ParseArhive {
    
    class func parse(completion: @escaping ([ArchiveItem]) -> ()) {
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                let arrayArchive = try decoder.decode([ArchiveItem].self, from: data)
                completion (arrayArchive)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        } else {
            completion ([])
        }
    }
}
