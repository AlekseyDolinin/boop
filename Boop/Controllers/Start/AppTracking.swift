import UIKit
#if canImport(AppTrackingTransparency)
import AppTrackingTransparency

extension StartViewController {
    
    func checkAppTrackingTransparency() {
#if canImport(AppTrackingTransparency)
        NotificationCenter.default.addObserver(self, selector: #selector(requestTrackingAuthorization), name: Notification.Name("requestAppTracking"), object: nil)
        
        if let statusATT =  UserDefaults.standard.string(forKey: "statusATTKey") {
            print("statusATT: \(statusATT)")
            if statusATT == "notDetermined" {
                showModalAppTrackingDescription()
            }
        } else {
            /// если статус нил - запроса не было
            showModalAppTrackingDescription()
        }
#endif
    }
    
    ///
    func showModalAppTrackingDescription() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard #available(iOS 14.5, *) else { return }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppTrackingModalViewController") as! AppTrackingModalViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    ///
    @objc open func requestTrackingAuthorization() {
        
        var statusAppTracking: String!
        
        #if DEBUG
        print("requestTrackingAuthorization")
        #endif
        guard #available(iOS 14.5, *) else { return }
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .notDetermined:
                print("notDetermined")
                statusAppTracking = "notDetermined"
                break
            case .restricted:
                print("restricted")
                statusAppTracking = "restricted"
                break
            case .denied:
                print("denied")
                statusAppTracking = "denied"
                break
            case .authorized:
                print("authorized")
                statusAppTracking = "authorized"
                break
            @unknown default:
                break
            }
            UserDefaults.standard.setValue(statusAppTracking, forKey: "statusATTKey")
        }
    }
}
#endif
