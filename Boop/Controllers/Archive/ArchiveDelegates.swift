import UIKit

extension ArchiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let archiveCell = tableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath) as! ArchiveCell
        let archiveCellFullVersion = tableView.dequeueReusableCell(withIdentifier: "ArchiveCellFullVersion", for: indexPath) as! ArchiveCellFullVersion
        archiveCell.archiveItem = arrayArchive[indexPath.row]
        archiveCell.setCell()
        archiveCellFullVersion.archiveItem = arrayArchive[indexPath.row]
        archiveCellFullVersion.setCell()
        return StoreManager.isFullVersion() ? archiveCellFullVersion : archiveCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailArchiveViewController") as! DetailArchiveViewController
        vc.archiveItem = arrayArchive[indexPath.row]
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            self.arrayArchive.remove(at: indexPath.row)
            self.viewSelf.archiveTable.reloadData()
            /// запись нового массива
            Archive.saveArchive(arrayArchive: self.arrayArchive)
        }
        deleteAction.image = UIImage(named: "trash.png")
        deleteAction.backgroundColor = .Violet_Dark_
        return UISwipeActionsConfiguration(actions: [deleteAction/*, muteAction*/])
    }
}
