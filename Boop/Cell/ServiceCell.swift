import UIKit

class ServiceCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameService: UILabel!
    @IBOutlet weak var exampleShortLink: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        // initialize what is needed
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // initialize what is needed
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 16
    }
}
