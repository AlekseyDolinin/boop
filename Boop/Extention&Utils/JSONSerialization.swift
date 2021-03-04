//import UIKit
//
//class JSON_ : NSObject {
//    
//    class func serialization(data: Data, completion: @escaping (String) -> Void) {
//        do {
//            // make sure this JSON is in the format we expect
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                
//                print("json: \(json)")
//                // try to read out a string array
//                if let resultURL = json["result_url"] {
//                    completion(resultURL as! String)
//                }
//            }
//        } catch let error as NSError {
//            print("Failed to load: \(error.localizedDescription)")
//        }
//    }
//}
