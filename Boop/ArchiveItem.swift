import UIKit

struct ArchiveItem: Codable {
    
    var id: String
    var name: String?
    var description: String?
    var shortLink: String
    var longLink: String
    var date: Date
    
    init(
        id: String,
        name: String? = nil,
        description: String? = nil,
        shortLink: String,
        longLink: String,
        date: Date
    ){
        self.id = id
        self.name = name
        self.description = description
        self.shortLink = shortLink
        self.longLink = longLink
        self.date = date
    }
}
