import UIKit

class MenuView: UIView {
    
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lButtonOne: UIButton!
    @IBOutlet weak var lButtonTwo: UIButton!
    @IBOutlet weak var lButtonThree: UIButton!
    @IBOutlet weak var lButtonFour: UIButton!
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
        
        lButtonOne.layer.cornerRadius = lButtonOne.frame.height / 2
        lButtonTwo.layer.cornerRadius = lButtonTwo.frame.height / 2
        lButtonThree.layer.cornerRadius = lButtonThree.frame.height / 2
        lButtonFour.layer.cornerRadius = lButtonFour.frame.height / 2
    }
}
