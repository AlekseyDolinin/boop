import UIKit
import SafariServices
import WebKit

class SafariViewController: SFSafariViewController, SFSafariViewControllerDelegate {
    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dismissButtonStyle = .close
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    ///
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("safariViewControllerDidFinish")
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print("initialLoadDidRedirectTo URL: \(URL)")
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print("didCompleteInitialLoad")
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
//        print("activityItemsFor URL: \(URL), title: \(title)")
        return [UIActivity]()
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, excludedActivityTypesFor URL: URL, title: String?) -> [UIActivity.ActivityType] {
//        print("excludedActivityTypesFor URL: \(URL), title: \(title)")
        return [UIActivity.ActivityType]()
    }
}
