import UIKit
import GoogleMobileAds
import Foundation

class ArchiveViewController: UIViewController, GADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var viewSelf: ArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! ArchiveView)
    }
    var arrayArchive = [ArchiveLink]()
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSelf.archiveTable.delegate = self
        viewSelf.archiveTable.dataSource = self
        
        setGadBanner()
        
        navigationController?.title = "Archive"
        
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                let arrayArchiveRaw = try decoder.decode([ArchiveView].self, from: data)
                print("arrayArchiveRaw: \(arrayArchiveRaw)")
                
                for i in arrayArchiveRaw {
                    print(i.title)
                    print(i.body)
                    print(i.id)
                }
                
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(arrayArchive)

    }
}
