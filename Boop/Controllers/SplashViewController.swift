import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var bg: UIImageView!
    
    static var archive = [ArchiveItem]()
    let priceManager = PriceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppLanguage.setLanguage()
        Archive.parse { arrayArchive in
            SplashViewController.archive = arrayArchive
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        versionLabel.text = GetVersionApp.get()
        startAnimation()
        /// получение цен покупок
        priceManager.getPricesForInApps(inAppsIDs: [booplinkFullversionID, booplinkSupportID])
    }
    
    ///
    func startAnimation() {
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
}
