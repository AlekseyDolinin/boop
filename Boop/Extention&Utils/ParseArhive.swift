import UIKit

class ParseArhive {
    
    class func parse(completion: @escaping ([ArchiveLink]) -> ()) {
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                let arrayArchive = try decoder.decode([ArchiveLink].self, from: data)
                completion (arrayArchive)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
}
