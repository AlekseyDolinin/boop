import Foundation
import UIKit

extension UIFont {

    public enum PTRootUIType: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
    }

    public static func PTRootUI(_ type: PTRootUIType, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        guard let cFont = UIFont(name: "PTRootUI-\(type.rawValue)", size: size) else {
            print("ERROR FONT: type:\(type.rawValue), size: \(size)")
            return UIFont.systemFont(ofSize: 14)
        }
        return cFont
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
}
