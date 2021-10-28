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
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



import UIKit

class MenuView: UIView {
    
    @IBOutlet weak var menuTable: UITableView!
    
    override func awakeFromNib() {

        setUI()
        
    }
    
    
    func configure() {

    }
}

extension MenuView {
    
    func setUI() {

    }
}
