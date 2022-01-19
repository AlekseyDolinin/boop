import UIKit

class DetailArchiveView: UIView {
    
    @IBOutlet weak var archiveItemTable: UITableView!
    @IBOutlet weak var copyShortLinkButton: ButtonBasic!
    @IBOutlet weak var copyLongLinkButton: ButtonBasic!
    @IBOutlet weak var qrCodeButton: ButtonBasic!
    @IBOutlet weak var shareShortLinkButton: ButtonBasic!
    @IBOutlet weak var openLongLinkButton: ButtonBasic!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var containerForPreviewImage: UIView!
    @IBOutlet weak var blureView: UIVisualEffectView!
    @IBOutlet weak var descriptionPreviewLabel: UILabel!
    @IBOutlet weak var getFullVersionButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var topIndicatorColorTag: UIView!
    @IBOutlet weak var yellowTagButton: UIButton!
    @IBOutlet weak var blueTagButton: UIButton!
    @IBOutlet weak var greenTagButton: UIButton!
    @IBOutlet weak var redTagButton: UIButton!
    @IBOutlet weak var clearTagButton: UIButton!
    
    
    
    
    var archiveItem: ArchiveItem!
    
    override func awakeFromNib() {
        setUI()
    }
    
    ///
    func configure() {
        setPreview()
    }
    
    ///
    func showLoader() {
        archiveItemTable.alpha = 0.3
        loader.startAnimating()
        isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.archiveItemTable.alpha = 1.0
            self.loader.stopAnimating()
            self.isUserInteractionEnabled = true
        }
    }
    
    ///
    func setPreview() {
        guard let url: URL = URL(string: archiveItem.previewLink ?? "") else {
            print("error url previewLink")
            previewImage.isHidden = true
            return
        }
        blureView.isHidden = StoreManager.isFullVersion()
        descriptionPreviewLabel.isHidden = StoreManager.isFullVersion()
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
        getFullVersionButton.isHidden = StoreManager.isFullVersion()
        loader.stopAnimating()
    }
    ///
    func setLabels() {
        copyShortLinkButton.setTitle(AppLanguage.dictionary["copyShortLink"]!.stringValue, for: .normal)
        copyLongLinkButton.setTitle(AppLanguage.dictionary["copyLongLink"]!.stringValue, for: .normal)
        qrCodeButton.setTitle(AppLanguage.dictionary["qrCode"]!.stringValue, for: .normal)
        shareShortLinkButton.setTitle(AppLanguage.dictionary["shareShortLink"]!.stringValue, for: .normal)
        openLongLinkButton.setTitle(AppLanguage.dictionary["openLongLink"]!.stringValue, for: .normal)
        getFullVersionButton.setTitle(AppLanguage.dictionary["getFullVersionInButton"]!.stringValue, for: .normal)
        descriptionPreviewLabel.text = AppLanguage.dictionary["descriptionPreview"]!.stringValue
    }
}
