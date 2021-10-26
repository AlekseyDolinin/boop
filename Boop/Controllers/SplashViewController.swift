import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVersionApp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    /// получение номера версии приложения
    func getVersionApp() {
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        versionLabel.text = "version: \(version)"
    }
}
