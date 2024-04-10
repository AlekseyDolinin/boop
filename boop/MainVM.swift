import UIKit

protocol MainVMDelegate: AnyObject {
    func getShortLinkSuccess()
}

final class MainVM {

    weak var delegate: MainVMDelegate?
    
    var selectedService: Service = .Ulvis
    var shortLink: String!
    let pasteboard = UIPasteboard.general
    
    func createShortLink(link: String) {
        Task(priority: .userInitiated) {
            print("selectedService: \(selectedService)")
            switch selectedService {
            case .Ulvis:
                await ulvis(longLink: link)
            case .Click:
                await click(longLink: link)
            case .Shortener:
                await shortener(longLink: link)
            default:
                print("selectedService: \(selectedService)")
                break
            }
            delegate?.getShortLinkSuccess()
        }
    }
    
    private func ulvis(longLink: String) async {
        let name = CreateName.shared.createName()
        let urlService = "https://ulvis.net/api.php?url=\(longLink)&custom=\(name)&private=1"
        shortLink = await API.shared._requestGetString(urlService, method: .get)
    }

    private func click(longLink: String) async {
        let urlService = "https://clck.ru/--?url=\(longLink)"
        shortLink = await API.shared._requestGetString(urlService, method: .get)
    }
    
    private func shortener(longLink: String) async {
        print("shortener")
        
        let link = "https://url-shortener-service.p.rapidapi.com/shorten"
        guard let url = URL(string: link) else { return }
        
        var request = URLRequest(url: url)

        request.setValue("type", forHTTPHeaderField: "application/x-www-form-urlencoded")
        request.setValue("x-rapidapi-key", forHTTPHeaderField: "15d2e6dcebmsh64156bb3423fc08p193afejsn6472465d2a74")
        request.setValue("x-rapidapi-host", forHTTPHeaderField: "url-shortener-service.p.rapidapi.com")
            
        let dataRequest = MultipartFormDataRequest(url: url)
        
        dataRequest.addTextField(named: "url", value: longLink)
        
        URLSession.shared.dataTask(with: dataRequest) { data, response, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            
//            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            print(data)
            print(response)
            print(error)
//            switch httpResponse.statusCode {
//            case 413:
//                self.delegate?.showAlert(text: gDict["fileIsBig"].stringValue)
//            case 400:
//                self.delegate?.showAlert(text: gDict["detail"].stringValue)
//            case 201:
//                self.delegate?.showAlert(text: gDict["messagePost"].stringValue)
//            default:
//                print("httpResponse.statusCode: \(httpResponse.statusCode)")
//                break
//            }
        }.resume()
    }
    
    
    
        
        
//        let urlService = "https://url-shortener-service.p.rapidapi.com/shorten"
//        let headers = [
//            "content-type": "application/x-www-form-urlencoded",
//            "x-rapidapi-key": "15d2e6dcebmsh64156bb3423fc08p193afejsn6472465d2a74",
//            "x-rapidapi-host": "url-shortener-service.p.rapidapi.com"
//        ]
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//               multipartFormData.append(longLink.data(using: .utf8)!, withName: "url")
//        }, to: urlService, method: .post, headers: headers) { (result) in
//            
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    let value = response.value as! [String: String]
//                    value.keys.first == "error" ? completion("") : completion(value["result_url"] ?? "")
//                }
//            case .failure( _): break
//            }
//        }
//    }
}











struct MultipartFormDataRequest {
    
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }

    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }

    func addDataField(named name: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }

    private func dataFormField(named name: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()
        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(name)\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        
        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        
        let str = String(decoding: request.httpBody!, as: UTF8.self)
        print(str)
        
        return request
    }
}


extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}


extension URLSession {
    func dataTask(with request: MultipartFormDataRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}
