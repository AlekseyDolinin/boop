import UIKit

class MenuViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var viewSelf: MenuView! {
        guard isViewLoaded else { return nil }
        return (view as! MenuView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        viewSelf.menuTable.delegate = self
        viewSelf.menuTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewSelf.configure()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



import UIKit

class MenuView: UIView {
    
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lButtonOne: UIButton!
    @IBOutlet weak var lButtonTwo: UIButton!
    @IBOutlet weak var lButtonThree: UIButton!
    @IBOutlet weak var lButtonFour: UIButton!
    
    
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
        container.layer.cornerRadius = container.frame.height / 2
        container.clipsToBounds = true
        
        lButtonOne.layer.cornerRadius = lButtonOne.frame.height / 2
        lButtonTwo.layer.cornerRadius = lButtonTwo.frame.height / 2
        lButtonThree.layer.cornerRadius = lButtonThree.frame.height / 2
        lButtonFour.layer.cornerRadius = lButtonFour.frame.height / 2
    }
}
