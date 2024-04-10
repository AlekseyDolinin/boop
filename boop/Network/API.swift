import Foundation

public class API {
    
    public static let shared = API()
        
    public func _requestGetString(_ link: String, 
                                  method: HTTPMethod = .get,
                                  parameters: Any? = nil) async -> String? {
        print("_request")
        guard let url = URL(string: link) else {
            print("BAD LINK: \(link)")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return nil }
            if httpResponse.statusCode != 200  {
                print("method: \(method)")
                print("parameters: \(parameters ?? "")")
                print("response: \(response)")
                print("description: \(response.description)")
                print("debugDescription: \(response.debugDescription)")
                return nil
            } else {
                return String(data: data, encoding: .utf8)
            }
        } catch {
            print("Неожиданная ошибка: \(error).")
            return nil
        }
    }

    public enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }
}
