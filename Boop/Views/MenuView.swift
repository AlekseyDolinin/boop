import UIKit

class MenuView: UIView {
    
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lButtonRussia: UIButton!
    @IBOutlet weak var lButtonUsa: UIButton!
    @IBOutlet weak var lButtonPortugal: UIButton!
    @IBOutlet weak var lButtonVietnam: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func awakeFromNib() {

        setUI()
        
    }
    
    
    func configure() {
        versionLabel.text = GetVersionApp.get()
    }
}

extension MenuView {
    
    func setUI() {
        
        
        ///
        backButton.setImage(UIImage(named: "backArrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        ///
        container.layer.cornerRadius = container.frame.height / 2
        container.clipsToBounds = true
        
        lButtonRussia.layer.cornerRadius = lButtonRussia.frame.height / 2
        lButtonUsa.layer.cornerRadius = lButtonUsa.frame.height / 2
        lButtonPortugal.layer.cornerRadius = lButtonPortugal.frame.height / 2
        lButtonVietnam.layer.cornerRadius = lButtonVietnam.frame.height / 2
    }
}
