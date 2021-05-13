import UIKit
//import AppTrackingTransparency

extension StartViewController {
    
    func showModalAppTrackingDescription() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            guard #available(iOS 14, *) else { return }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppTrackingModalViewController") as! AppTrackingModalViewController
            self.present(vc, animated: true)
        }
    }

    @objc open func requestTrackingAuthorization() {

        #if DEBUG
        print("requestTrackingAuthorization")
        #endif
        
//        ATTrackingManager.requestTrackingAuthorization { _ in
//            DispatchQueue.main.async { [weak self] in
//                // self?.router.close() or nothing to do
//            }
//        }
    }

}
