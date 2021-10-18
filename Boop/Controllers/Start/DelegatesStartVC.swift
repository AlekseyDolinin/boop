import UIKit

extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayKeysServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let serviceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        serviceCell.nameService.text = "\(arrayKeysServices[indexPath.row])"
        serviceCell.exampleShortLink.text = arrayKeysServices[indexPath.row].rawValue
        StartViewController.selectedService = arrayKeysServices[indexPath.row]
        return serviceCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in viewSelf.collectionServices.visibleCells {
            if let index = (viewSelf.collectionServices.indexPath(for: cell))?.row {
                indexSelectedService = index
                viewSelf.pagination.currentPage = index
                StartViewController.selectedService = arrayKeysServices[index]
                viewSelf.linkLabel.text = "Paste the link here"
                viewSelf.alphaStackActionButtons(valueAlpha: 0.0, duration: 0)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
