import UIKit

extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        for cell in startView.collectionServices.visibleCells {
            if let index = (startView.collectionServices.indexPath(for: cell))?.row {
                indexSelectedService = index
                StartViewController.selectedService = arrayKeysServices[index]
                startView.linkLabel.text = "Paste the link here"
                startView.alphaStackActionButtons(valueAlpha: 0.0, duration: 0)
            }
        }
    }
    
    /// центрирование ячеек
//    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
//        let totalWidth = cellWidth * numberOfItems
//        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
//        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
//            let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section),
//            dataSourceCount > 0 else {
//                return .zero
//        }
//
//        let cellCount = CGFloat(dataSourceCount)
//        let itemSpacing = flowLayout.minimumInteritemSpacing
//        let cellWidth = flowLayout.itemSize.width + itemSpacing
//        var insets = flowLayout.sectionInset
//
//        let totalCellWidth = (cellWidth * cellCount) - itemSpacing
//        let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
//
//        guard totalCellWidth < contentWidth else {
//            return insets
//        }
//
//        let padding = (contentWidth - totalCellWidth) / 2.0
//        insets.left = padding
//        insets.right = padding
//        return insets
//    }
}
