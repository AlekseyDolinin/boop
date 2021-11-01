import UIKit

class ParseArhive {
    
    class func parse() {
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                self.arrayArchive = try decoder.decode([ArchiveLink].self, from: data)
                print("arrayArchive_1: \(self.arrayArchive)")
                completion (true)
            } catch {
                print("Unable to Decode Notes (\(error))")
                completion (false)
            }
        } else {
            print("Первая запись в архив")
            completion (true)
        }
    }
}
