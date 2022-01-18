import UIKit

class ButtonBasic: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        titleLabel?.font = UIFont(name: "SFCompactRounded-Regular", size: 16)
        tintColor = .white
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}

///
//class ButtonClose: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        let originalImage = UIImage(named: "iconClose")
//        let tintedImage = originalImage?.withRenderingMode(.alwaysTemplate)
//        self.setImage(tintedImage, for: .normal)
//        self.tintColor = AppTheme.BB_TextPrimary
//        self.imageView?.contentMode = .scaleAspectFit
//        self.contentHorizontalAlignment = .fill
//        self.contentVerticalAlignment = .fill
//    }
//}


///
//class ButtonFirst: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        self.setTitleColor(AppTheme.BB_BGPrimary, for: .normal)
//        self.backgroundColor = AppTheme.BB_TextUI2
//        self.layer.cornerRadius = 5
//        self.titleLabel?.font = UIFont(name: "PTRootUI-Medium", size: 16)!
//    }
//}


///
//class ButtonSecond: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        self.setTitleColor(AppTheme.BB_TextPrimary, for: .normal)
//        self.backgroundColor = AppTheme.BB_BGSecondary
//        self.layer.cornerRadius = 5
//        self.titleLabel?.font = UIFont(name: "PTRootUI-Medium", size: 16)!
//    }
//}


///
//class ButtonThree: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        self.setTitleColor(AppTheme.BB_TextUI2, for: .normal)
//        self.backgroundColor = AppTheme.BB_TextUI2.withAlphaComponent(0.12)
//        self.layer.cornerRadius = 5
//    }
//}


/////
//class ButtonRed: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        self.setTitleColor(AppTheme.BB_TextPrimary, for: .normal)
//        self.backgroundColor = AppTheme.BB_FixedUIRed90
//        self.layer.cornerRadius = 5
//    }
//}


///
//class ButtonGreen: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        self.setTitleColor(AppTheme.BB_TextPrimary, for: .normal)
//        self.backgroundColor = AppTheme.BB_FixedUIGreen90
//        self.layer.cornerRadius = 5
//    }
//}

///
//class ButtonMaterial: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        setTitleColor(AppTheme.BB_TextPrimary, for: .normal)
//        backgroundColor = .clear
//        tintColor = AppTheme.BB_TextPrimary
//        titleLabel?.lineBreakMode = .byTruncatingHead
//        translatesAutoresizingMaskIntoConstraints = false
//        titleLabel?.font = UIFont(name: "PTRootUI-Regular", size: 14)!
//        contentHorizontalAlignment = .leading
//        imageView?.contentMode = .scaleAspectFit
//        titleEdgeInsets = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 12)
//    }
//}

/////
//class ButtonHeaderSelectOpponent: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    private func setup() {
//        layer.cornerRadius = 8
//        setTitleColor(AppTheme.BB_TextPrimary, for: .normal)
//        backgroundColor = AppTheme.BB_BGSecondary
//    }
//}
