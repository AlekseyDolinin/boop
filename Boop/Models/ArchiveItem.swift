import UIKit

struct ArchiveItem: Codable {
    
    var id: String
    var name: String?
    var description: String?
    var shortLink: String
    var longLink: String
    var date: Date
    var iconLink: String?
    var previewLink: String?
    var tagColor: String?
    
    init(
        id: String,
        name: String? = nil,
        description: String? = nil,
        shortLink: String,
        longLink: String,
        date: Date,
        iconLink: String? = nil,
        previewLink: String? = nil,
        tagColor: String? = nil
    ){
        self.id = id
        self.name = name
        self.description = description
        self.shortLink = shortLink
        self.longLink = longLink
        self.date = date
        self.iconLink = iconLink
        self.previewLink = previewLink
        self.tagColor = tagColor
    }
}
