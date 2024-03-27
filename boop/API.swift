import Foundation

public class API {
    
    public static let shared = API()
        
    public func _request(_ link: String, method: HTTPMethod = .get, parameters: Any? = nil, needCookie: Bool = true) async -> JSON? {
        guard let url = URL(string: link) else {
            print("BAD LINK: \(link)")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            } catch let error {
                print("error_add_parameters: \(error.localizedDescription)")
                return nil
            }
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return nil }
            if httpResponse.statusCode != 200  {
                print("method: \(method)")
                print("parameters: \(parameters)")
                print("response: \(response)")
            }
            return JSON(data)
        } catch {
            print("Неожиданная ошибка: \(error).")
            return nil
        }
    }
    
//    public func setCookieInRequest(_ request_: inout URLRequest) {
//        guard let savedCookie = UserDefaults.standard.dictionary(forKey: .cookiesKey) else { return }
//        guard let dictionary = savedCookie["user_id"] as? Dictionary<String, Any> else { return }
//        guard let value: String = dictionary["Value"] as? String else { return }
//        guard let name: String = dictionary["Name"] as? String else { return }
//        let cookies_header = "\(name)=\(value); " + "language=\(gLanguage.rawValue);"
//        request_.setValue(cookies_header, forHTTPHeaderField: "Cookie")
//    }

    public enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }
    
}
