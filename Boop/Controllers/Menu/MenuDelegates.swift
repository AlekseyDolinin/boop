import UIKit

extension MenuViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "ArchiveMenuCell", for: indexPath) as! ArchiveMenuCell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "LanguageMenuCell", for: indexPath) as! LanguageMenuCell
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "RemoveADMenuCell", for: indexPath) as! RemoveADMenuCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
            navigationController?.pushViewController(vc!, animated: true)
        case 1:
            print(indexPath.row)
        case 2:
            print(indexPath.row)
        default:
            break
        }
    }
}
