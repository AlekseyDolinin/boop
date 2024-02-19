import SwiftLinkPreview

class ParseHTML {
    ///
    class func parse(link: String, completion: @escaping (Response) -> ()) {
        let slp = SwiftLinkPreview(session: URLSession.shared,
                                   workQueue: SwiftLinkPreview.defaultWorkQueue,
                                   responseQueue: DispatchQueue.main,
                                   cache: DisabledCache.instance)
        slp.preview(link,
                    onSuccess: { result in
            completion(Response(title: result.title ?? "",
                                description: result.description ?? "",
                                image: result.image ?? "",
                                icon: result.icon ?? ""))
        }, onError: { error in
            print("Error parse html: \(error)")})
    }
}
