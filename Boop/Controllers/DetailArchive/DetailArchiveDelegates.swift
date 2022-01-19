import UIKit
import SafariServices
import GoogleMobileAds

extension DetailArchiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let archiveDetailCell = tableView.dequeueReusableCell(withIdentifier: "ArchiveDetailCell", for: indexPath) as! ArchiveDetailCell
        
        return archiveDetailCell
    }
    
}
