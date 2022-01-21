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
    @IBOutlet weak var msgPreviewLabel: UILabel!
    @IBOutlet weak var descriptionPreviewLabel: UILabel!
    @IBOutlet weak var getFullVersionButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var topIndicatorColorTag: UIView!
    @IBOutlet weak var yellowTagButton: UIButton!
    @IBOutlet weak var blueTagButton: UIButton!
    @IBOutlet weak var greenTagButton: UIButton!
    @IBOutlet weak var redTagButton: UIButton!
    @IBOutlet weak var clearTagButton: UIButton!
    
    @IBOutlet weak var stackTagButtons: UIStackView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var archiveItem: ArchiveItem!
    
    override func awakeFromNib() {
        setUI()
    }
    
    ///
    func configure() {
        setPreview()
        setColorTag()
    }
    
    func setColorTag() {
        switch archiveItem.tagColor {
        case "yellowTag":
            topIndicatorColorTag.backgroundColor = .Yellow_
            yellowTagButton.setImage(UIImage(named: "colorTag"), for: .normal)
        case "blueTag":
            topIndicatorColorTag.backgroundColor = .Blue_
            blueTagButton.setImage(UIImage(named: "colorTag"), for: .normal)
        case "greenTag":
            topIndicatorColorTag.backgroundColor = .Green_
            greenTagButton.setImage(UIImage(named: "colorTag"), for: .normal)
        case "redTag":
            topIndicatorColorTag.backgroundColor = .Red_
            redTagButton.setImage(UIImage(named: "colorTag"), for: .normal)
        case "clearTag":
            topIndicatorColorTag.backgroundColor = .clear
        default:
            break
        }
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
        
        if !StoreManager.isFullVersion() {
            msgPreviewLabel.isHidden = false
            previewImage.image = UIImage(named: "bg_1")
            msgPreviewLabel.text = AppLanguage.dictionary["descriptionPreview"]!.stringValue
            descriptionPreviewLabel.isHidden = true
            return
        }
        
        self.previewImage.image = UIImage(named: "bg_1")
        self.msgPreviewLabel.text = AppLanguage.dictionary["errorGetLinkPrew"]!.stringValue
        descriptionPreviewLabel.isHidden = false
        descriptionPreviewLabel.text = AppLanguage.dictionary["errorGetLinkPrewDescription"]!.stringValue
        
        if let previewLink = archiveItem.previewLink {
            guard let url: URL = URL(string: previewLink) else {
                return
            }
            LoadImage.get(urlImage: url) { image in
                self.msgPreviewLabel.isHidden = true
                self.descriptionPreviewLabel.isHidden = true
                self.previewImage.image = image
            }
        }
    }
}

extension DetailArchiveView {
    ///
    func setUI() {
        setLabels()
        
        //
        getFullVersionButton.isHidden = StoreManager.isFullVersion()
        loader.stopAnimating()
        
        //
        if !StoreManager.isFullVersion() {
            stackTagButtons.isHidden = true
            topConstraint.constant = 40
        }
        
    }
    ///
    func setLabels() {
        copyShortLinkButton.setTitle(AppLanguage.dictionary["copyShortLink"]!.stringValue, for: .normal)
        copyLongLinkButton.setTitle(AppLanguage.dictionary["copyLongLink"]!.stringValue, for: .normal)
        qrCodeButton.setTitle(AppLanguage.dictionary["qrCode"]!.stringValue, for: .normal)
        shareShortLinkButton.setTitle(AppLanguage.dictionary["shareShortLink"]!.stringValue, for: .normal)
        openLongLinkButton.setTitle(AppLanguage.dictionary["openLongLink"]!.stringValue, for: .normal)
        getFullVersionButton.setTitle(AppLanguage.dictionary["getFullVersionInButton"]!.stringValue, for: .normal)
    }
}
