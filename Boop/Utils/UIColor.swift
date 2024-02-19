import UIKit

public extension UIColor {
    
    class func hexStringToUIColor (hex: String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var hsba:(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }
}


public extension UIColor {
    
    static var BB_BGPrimary = UIColor()
    static var BB_BGSecondary = UIColor()
    static var BB_BGTertiary = UIColor()

    static var BB_PrimaryUI = #colorLiteral(red: 0.9607843137, green: 0.9058823529, blue: 0.431372549, alpha: 1)
    static var BB_SecondaryUI = UIColor()
    
    static var BB_TextUI = UIColor()
    static var BB_TextOnPrimary = UIColor()
    static var BB_RedUI = UIColor()
    static var BB_GreenUI = UIColor()
    static var BB_WarningUI = UIColor()
    
    static var BB_SPPrimary = UIColor()
    static var BB_SPSecondary = UIColor()
    static var BB_SPWhite = UIColor()
    
    static var Surface_BB_00db = UIColor()
    static var Surface_BB_01db = UIColor()
    static var Surface_BB_02db = UIColor()
    static var Surface_BB_03db = UIColor()
    
    static var DEL_PrimaryBRAND = UIColor()

    static var DEL_SecondaryBRAND = UIColor()

    static var BB_TextPrimary = UIColor()
    static var BB_TextSecondary = UIColor()
    static var BB_TextHigh = UIColor()
    static var BB_TextMedium = UIColor()
    static var BB_TextDisabled = UIColor()
    static var BB_TextOnPrimaryHigh = UIColor()
    static var BB_TextOnPrimaryMedium = UIColor()
    static var BB_TextOnPrimaryDisabled = UIColor()

    static var BB_SPOutline1 = UIColor()
    static var BB_SPOutline2 = UIColor()
}
