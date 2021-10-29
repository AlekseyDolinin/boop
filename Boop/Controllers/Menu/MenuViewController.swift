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
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        UserDefaults.standard.set(sender.tag, forKey: "TagSelectLanguage")
        UserDefaults.standard.synchronize()
        AppLanguage.setLanguage()
        
        self.view.layoutIfNeeded()
        viewDidLoad()
        viewSelf.menuTable.reloadData()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
