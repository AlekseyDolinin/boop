import UIKit
import SafariServices
import GoogleMobileAds

class DetailArchiveViewController: UIViewController, GADInterstitialDelegate {

    var viewSelf: DetailArchiveView! {
        guard isViewLoaded else { return nil }
        return (view as! DetailArchiveView)
    }
    
    var archiveItem: ArchiveItem!
    var interstitial: GADInterstitial!
    let pasteboard = UIPasteboard.general
    var storeManager = StoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.archiveItemTable.delegate = self
        viewSelf.archiveItemTable.dataSource = self
        viewSelf.archiveItem = self.archiveItem
        viewSelf.configure()
        if StoreManager.isFullVersion() == false {
            setGadFullView()
        }
        ///
        NotificationCenter.default.addObserver(forName: nTransactionComplate, object: nil, queue: nil) { notification in
            DispatchQueue.main.async {
                print("модалка благодарности покупки")
                self.dismiss(animated: true) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        viewSelf.setColorTag()
    }
    
    /// авторесайз футера таблицы
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let footerView = viewSelf.archiveItemTable.tableFooterView else {return}
        let size = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            viewSelf.archiveItemTable.tableFooterView = footerView
            viewSelf.archiveItemTable.layoutIfNeeded()
        }
    }
    
    ///
    func showControllerShare() {
        let shareController = UIActivityViewController(activityItems: [archiveItem.shortLink as Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                print("it is done!")
            } else {
                print("error send")
            }
        }
        present(shareController, animated: true)
    }
    
    ///
    func showAlertCopy() {
        let alert = UIAlertController(title: nil, message: AppLanguage.dictionary["linkCopied"]!.stringValue, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true)
        }
    }
    
    //
    @IBAction func selectColorTag(_ sender: UIButton) {
        archiveItem.tagColor = sender.restorationIdentifier ?? "clearTag"
        
        viewSelf.yellowTagButton.setImage(UIImage(named: "colorTagDeselect"), for: .normal)
        viewSelf.blueTagButton.setImage(UIImage(named: "colorTagDeselect"), for: .normal)
        viewSelf.greenTagButton.setImage(UIImage(named: "colorTagDeselect"), for: .normal)
        viewSelf.redTagButton.setImage(UIImage(named: "colorTagDeselect"), for: .normal)
        
        // назначение тэга
        self.archiveItem.tagColor = sender.restorationIdentifier ?? "clearTag"
        viewSelf.archiveItem = self.archiveItem
        viewSelf.setColorTag()
        
        // поиск и замена ссылки в архиве
        for (index, archiveItem) in  SplashViewController.archive.enumerated() {
            if archiveItem.id == self.archiveItem.id {
                SplashViewController.archive[index] = self.archiveItem
                // сообщение что ссылка изменена
                NotificationCenter.default.post(name: nArchiveItemEdit, object: nil)
            }
        }
    }
    
    //
    @IBAction func copyShortLink(_ sender: Any) {
        pasteboard.string = archiveItem.shortLink
        showAlertCopy()
    }
    
    //
    @IBAction func copyLongLink(_ sender: Any) {
        pasteboard.string = archiveItem.longLink
        showAlertCopy()
    }
    
    //
    @IBAction func qrCode(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
        vc.linkForQRCode = archiveItem.shortLink
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
    
    //
    @IBAction func shareShortLink(_ sender: Any) {
        if StoreManager.isFullVersion() {
            self.showControllerShare()
        } else {
            if self.interstitial.isReady == true {
                print("ролик готов")
                self.interstitial.present(fromRootViewController: self)
            } else {
                self.showControllerShare()
            }
        }
    }
    
    //
    @IBAction func openLongLink(_ sender: Any) {
        if let url = URL(string: self.archiveItem.longLink) {
            let vc = SafariViewController(url: url, configuration: SFSafariViewController.Configuration())
            self.present(vc, animated: true)
        }
    }
    
    ///
    @IBAction func getFullVersion(_ sender: UIButton) {
        print("getFullVersion")
        viewSelf.showLoader()
        storeManager.buyInApp(inAppID: booplinkFullversionID)
    }
    
    ///
    @IBAction func closeView (_ sender: UIButton) {
        dismiss(animated: true)
    }
}
