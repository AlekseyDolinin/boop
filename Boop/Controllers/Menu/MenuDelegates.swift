import UIKit

extension MenuViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "ArchiveMenuCell", for: indexPath) as! ArchiveMenuCell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "RemoveADMenuCell", for: indexPath) as! RemoveADMenuCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
            navigationController?.pushViewController(vc!, animated: true)        }
        else {
            print(indexPath.row)
        }
    }
}
