import UIKit

class DetailArchiveView: UIView {
    
    @IBOutlet weak var archiveItemTable: UITableView!
    @IBOutlet weak var copyShortLinkButton: ButtonBasic!
    @IBOutlet weak var copyLongLinkButton: ButtonBasic!
    @IBOutlet weak var qrCodeButton: ButtonBasic!
    @IBOutlet weak var shareShortLinkButton: ButtonBasic!
    @IBOutlet weak var openLongLinkButton: ButtonBasic!
        
    override func awakeFromNib() {
        setUI()
    }
}

extension DetailArchiveView {
    ///
    func setUI() {
        setLabels()
        ///


        
    }
    ///
    func setLabels() {
        copyShortLinkButton.setTitle(AppLanguage.dictionary["copyShortLink"]!.stringValue, for: .normal)
        copyLongLinkButton.setTitle(AppLanguage.dictionary["copyLongLink"]!.stringValue, for: .normal)
        qrCodeButton.setTitle(AppLanguage.dictionary["qrCode"]!.stringValue, for: .normal)
        shareShortLinkButton.setTitle(AppLanguage.dictionary["shareShortLink"]!.stringValue, for: .normal)
        openLongLinkButton.setTitle(AppLanguage.dictionary["openLongLink"]!.stringValue, for: .normal)
    }
}
