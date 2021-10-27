import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
