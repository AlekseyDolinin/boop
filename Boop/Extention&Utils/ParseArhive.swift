import UIKit

class ParseArhive {
    
    class func parse(completion: @escaping ([ArchiveItem]) -> ()) {
        print("ParseArhive")
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                var arrayArchive = try decoder.decode([ArchiveItem].self, from: data)
                arrayArchive = arrayArchive.sorted {$0.date > $1.date}
                completion (arrayArchive)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        } else {
            completion ([])
        }
    }
    
    ///
    class func saveArchive(arrayArchive: [ArchiveItem]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(arrayArchive)
            UserDefaults.standard.set(data, forKey: "arrayArchive")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
}
