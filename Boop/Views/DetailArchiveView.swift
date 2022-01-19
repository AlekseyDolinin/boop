import UIKit

class DetailArchiveView: UIView {
    
    @IBOutlet weak var archiveItemTable: UITableView!
    @IBOutlet weak var copyShortLinkButton: ButtonBasic!
    @IBOutlet weak var copyLongLinkButton: ButtonBasic!
    @IBOutlet weak var qrCodeButton: ButtonBasic!
    @IBOutlet weak var shareShortLinkButton: ButtonBasic!
    @IBOutlet weak var openLongLinkButton: ButtonBasic!
    @IBOutlet weak var previewImage: UIImageView!
    
    var archiveItem: ArchiveItem!
    
    override func awakeFromNib() {
        setUI()
    }
    
    ///
    func configure() {
        setPreview()
    }
    
    ///
    func setPreview() {
        guard let url: URL = URL(string: archiveItem.previewLink ?? "") else {
            print("error url previewLink")
            previewImage.isHidden = true
            return
        }
        LoadImage.get(urlImage: url) { image in
            self.previewImage.image = image
        }
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
