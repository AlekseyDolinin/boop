import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var bg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVersionApp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.2) {
                self.logoImage.alpha = 0
            } completion: { bool in
                UIView.animate(withDuration: 0.2) {
                    self.bg.alpha = 0
                } completion: { bool in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController")
                    self.navigationController?.pushViewController(vc!, animated: false)
                }
            }
        }
    }
    
    /// получение номера версии приложения
    func getVersionApp() {
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        versionLabel.text = "version: \(version)"
    }
}
