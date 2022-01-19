import UIKit

class Archive {
    
    class func parse(completion: @escaping ([ArchiveItem]) -> ()) {
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
    
    ///
    class func addItemInArchive(longLink: String, shortLink: String) {
        Archive.createArchiveItem(longLink: longLink, shortLink: shortLink) { archiveItem in
            SplashViewController.archive.append(archiveItem)
            saveArchive(arrayArchive: SplashViewController.archive)
        }
    }
    
    ///
    class func createArchiveItem(longLink: String, shortLink: String, completion: @escaping (ArchiveItem) -> ()) {
        ParseHTML.parse(link: longLink) { response in
            completion(ArchiveItem(id: UUID().uuidString,
                                   name: response.title,
                                   description: nil,
                                   shortLink: shortLink,
                                   longLink: longLink,
                                   date: Date(),
                                   iconLink: response.icon,
                                   previewLink: response.image))
        }
    }
}
