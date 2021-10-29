import Foundation

class GetVersionApp {
    
    class func get() -> String {
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        return "Version \(version)"
    }
}
