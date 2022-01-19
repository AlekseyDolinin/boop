import SwiftLinkPreview

class ParseHTML {
    ///
    class func parse(link: String, completion: @escaping (Response) -> ()) {
        let slp = SwiftLinkPreview(session: URLSession.shared,
                                   workQueue: SwiftLinkPreview.defaultWorkQueue,
                                   responseQueue: DispatchQueue.main,
                                   cache: DisabledCache.instance)
        slp.preview(link,
                    onError: { error in
            print("Error parse html: \(error)")},
                    onSuccess: { result in
            
            /// вырезание из текста не нужных символов
            let descriptionOne = result.description?.replacingOccurrences(of: "&nbsp;", with: " ")
            /// вырезание из текста html tags
            let descriptionTwo = descriptionOne?.replacingOccurrences(of: "<[^>]+>", with: "")
            
            completion(Response(title: result.title ?? "Title not found",
                                description: descriptionTwo ?? "Description not found",
                                image: result.image ?? "",
                                icon: result.icon ?? ""))
        })
    }
}
