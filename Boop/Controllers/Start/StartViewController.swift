import UIKit
import SwiftyJSON
import Foundation

enum Service: String, CaseIterable {
    case Isgd = "https://is.gd/*"
    case Shortener = "https://goolnk.com/*"
    case TinyURL = "https://tiny.one/*"
    case Click = "https://clck.ru/*"
}

final class StartViewController: UIViewController {
    
    private let bgImage = UIImageView()
    private let menuButton = UIButton()
    private let scrollServices = UIScrollView()
    private let pageControl = UIPageControl()
    private let pastLinkButton = UIButton()
    private let infoLabel = PaddingLabel()
    private let archiveButton = UIButton()
    private let stackActionsButton = UIStackView()
    private let backButton = UIButton()
    private let copyButton = UIButton()
    private let qrButton = UIButton()
    private let shareButton = UIButton()
    private let saveButton = UIButton()
    
//    static let shared = StartViewController()
    

    
    var currentIndexService = 0
    var selectedService: Service = .Isgd
    
    func animationSaveInArchive() {
        UIView.animate(withDuration: 0.4) {
            self.menuButton.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.menuButton.transform = CGAffineTransform(rotationAngle: Double.pi * 3)
        } completion: { bool in
            self.menuButton.transform = .identity
        }
    }
    
//    var services: [Service] = [.Isgd, .Shortener, .TinyURL, .Click]
    
//    enum Actions: String {
//        case copy = "copy"
//        case share = "share"
//        case none = "none"
//    }
    
//    static var selectedService: Service = .Isgd
//    static var shortLink: String!
    
//    let pasteboard = UIPasteboard.general
//    var longLink: String!
    var shortLink: String!
//    var services: [Service] = [.Isgd, .Shortener, .TinyURL, .Click]
//    var indexSelectedService = 0
//    var action: Actions = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        
//        viewSelf.collectionServices.delegate = self
//        viewSelf.collectionServices.dataSource = self
//        viewSelf.configure()
//        setPagination()
//        checkAppTrackingTransparency()
//        ///
//        NotificationCenter.default.addObserver(forName: nTransactionComplate, object: nil, queue: nil) { notification in
//            if let banner = self.bannerView {
//                banner.isHidden = true
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if StartViewController.shortLink == nil {
//            self.viewSelf.configure()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if StoreManager.isFullVersion() == false {
//            setGadBanner()
//            setGadFullView()
//        }
    }
    
    ///
    func setPagination() {
//        viewSelf.pagination.numberOfPages = arrayKeysServices.count
//        viewSelf.pagination.currentPage = indexSelectedService
//        viewSelf.pagination.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    

    
    ///
//    func showResult(resutShortUrl: String) {
//        self.viewSelf.showMessage(text: AppLanguage.dictionary["done"]!.stringValue)
//        self.viewSelf.linkLabel.text = resutShortUrl
//        StartViewController.shortLink = resutShortUrl
//        self.viewSelf.shortLink = resutShortUrl
//        self.viewSelf.alphaStackActionButtons(valueAlpha: 1.0, duration: 0.2)
//    }
    
    ///
    func showControllerShare() {
//        let shareController = UIActivityViewController(activityItems: [StartViewController.shortLink as Any], applicationActivities: nil)
//        shareController.completionWithItemsHandler = {_, bool, _, _ in
//            if bool {
//                print("it is done!")
//            } else {
//                print("error send")
//            }
//        }
//        present(shareController, animated: true)
    }
    
    ///
    func copiedShortLink() {
//        pasteboard.string = StartViewController.shortLink
//        viewSelf.showMessage(text: AppLanguage.dictionary["linkCopied"]!.stringValue)
    }

    ///
    func addItemInArchive() {
//        if StoreManager.isFullVersion() {
//            Archive.addItemInArchive(longLink: self.longLink)
//        } else {
//            ///проверка количества записей
//            if SplashViewController.archive.count >= 10 {
//                self.showAlert()
//            } else {
//                Archive.addItemInArchive(longLink: self.longLink)
//            }
//        }
    }
    
    ///
    func openArchive() {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
//        navigationController?.pushViewController(vc!, animated: true)
    }
    
    ///
    func showAlert() {
//        
//        let titleFullArchive = AppLanguage.dictionary["titleFullArchive"]!.stringValue
//        let mesageFullArchive = AppLanguage.dictionary["messageFullArchive"]!.stringValue
//        let close = AppLanguage.dictionary["close"]!.stringValue
//        let gotoArchive = AppLanguage.dictionary["gotoArchive"]!.stringValue
//        
//        let alert = UIAlertController(title: titleFullArchive, message: mesageFullArchive, preferredStyle: .alert)
//        let actionClose = UIAlertAction(title: close, style: .destructive)
//        let actionGoToArchive = UIAlertAction(title: gotoArchive, style: .default) { UIAlertAction in
//            self.openArchive()
//        }
//        alert.addAction(actionGoToArchive)
//        alert.addAction(actionClose)
//        present(alert, animated: true)
    }
        
        
        
        ///
//        @objc func openMenu() {
            
//            print("openMenu")
            /// проверка сосотояния покупок
//            let priceFullVersion = UserDefaults.standard.object(forKey: booplinkFullversionID)
//            let priceSupport = UserDefaults.standard.object(forKey: booplinkSupportID)
//            if priceFullVersion == nil && priceSupport == nil {
//                print("цены не получены")
//                let vc = storyboard?.instantiateViewController(withIdentifier: "MenuNoPriceViewController") as! MenuNoPriceViewController
//                navigationController?.pushViewController(vc, animated: true)
//            } else {
//                if StoreManager.isFullVersion() {
//                    let vc = storyboard?.instantiateViewController(withIdentifier: "MenuFullVersionViewController") as! MenuFullVersionViewController
//                    navigationController?.pushViewController(vc, animated: true)
//                } else {
//                    let vc = storyboard?.instantiateViewController(withIdentifier: "MenuNoFullViewController") as! MenuNoFullViewController
//                    navigationController?.pushViewController(vc, animated: true)
//                }
//            }
//        }
    
    @objc func openMenuAction() {
        print("openMenuAction")
    }
    
    @objc func openArchiveAction() {
        print("openArchiveAction")
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
        //        navigationController?.pushViewController(vc!, animated: true)
    }
        
    @objc func backAction(_ sender: UIButton) {
        print("backAction")
    }
    
    @objc func copyAction(_ sender: UIButton) {
        print("copyAction")
    }
    
    @objc func qrAction(_ sender: UIButton) {
        print("qrAction")
    }
    
    @objc func shareAction(_ sender: UIButton) {
        print("shareAction")
    }
    
    @objc func saveAction(_ sender: UIButton) {
        print("saveAction")
    }
    
    @objc func pastAction(_ sender: UIButton) {
        if shortLink != nil { return }
        guard let text = UIPasteboard.general.string else {
            print("text is empty")
            return
        }
        guard let encodeString = text.encodeUrl() else {
            print("error encodeString")
            return
        }
//        print("encodeString: \(encodeString)")
//        print("currentIndexService: \(currentIndexService)")
        
        // проверка вставлена ссылка или просто текст
        if let longLink = URL(string: encodeString), let scheme = longLink.scheme {
            if scheme != "https" && scheme != "http" {
                showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
                return
            }
            showMessage(text: AppLanguage.dictionary["pleaseWait"]!.stringValue)
            pastLinkButton.setTitle(UIPasteboard.general.string, for: .normal)
            pastLinkButton.isUserInteractionEnabled = false
            createShortLink(longLink.absoluteString)
        }
    }
    


    func createShortLink(_ longLink: String) {
        print("longLink: \(longLink)")
        API.selectService(longLink, service: Service.allCases[currentIndexService]) { (shortLink) in
            
            print("shortLink: \(shortLink)")
            
//            self.viewSelf.placeLinkButton.isUserInteractionEnabled = true
//            DispatchQueue.main.async {
//                if responseShortLink != "" {
//                    self.showResult(resutShortUrl: responseShortLink)
//                } else {
//                    self.viewSelf.showMessage(text: AppLanguage.dictionary["errorMsg"]!.stringValue)
//                }
//            }
        }
    }
    
    
    //
    func showMessage(text: String) {
        infoLabel.text = text

        UIView.animate(withDuration: 0.1, animations: {
            self.infoLabel.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.1, delay: 2.0, options: .curveLinear, animations: {
                self.infoLabel.alpha = 0
            }, completion: { (true) in
                print("hide message")
            })
        }
    }
    
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let newIndex = sender.currentPage
        if newIndex < 0 { return }
        if newIndex != currentIndexService {
            currentIndexService = newIndex
            selectedService = Service.allCases[currentIndexService]
            scrollServices.setContentOffset(CGPoint(x: CGFloat(currentIndexService) * view.frame.size.width, y: 0), animated: true)
        }
    }
}


extension StartViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newIndex = Int(floorf(Float(scrollView.contentOffset.x) / Float(view.frame.size.width)))
        if newIndex < 0 { return }
        if newIndex != currentIndexService {
            currentIndexService = newIndex
            pageControl.currentPage = currentIndexService
            selectedService = Service.allCases[currentIndexService]
        }
    }
}


extension StartViewController {
    
    private func createSubviews() {
        createBGImage()
        createMenuButton()
        createScrollServices()
        createPageControl()
        createPastLinkButton()
        createInfoLabel()
        createStackActionsButton()
        createBackButton()
        createCopyButton()
        createQrButton()
        createShareButton()
        createSaveButton()
        createArchiveButton()
    }
    
    private func createBGImage() {
        view.addSubview(bgImage)
        bgImage.contentMode = .scaleAspectFill
        bgImage.image = UIImage(named: "bg_1")
        //
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        bgImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bgImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createMenuButton() {
        view.addSubview(menuButton)
        menuButton.tintColor = .Violet_Dark_
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        menuButton.setImage(UIImage(systemName: "line.3.horizontal", withConfiguration: configuration), for: .normal)
        menuButton.addTarget(self, action: #selector(openMenuAction), for: .touchUpInside)
        //
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func createScrollServices() {
        view.addSubview(scrollServices)
        scrollServices.backgroundColor = .clear
        scrollServices.alwaysBounceHorizontal = true
        scrollServices.delegate = self
        scrollServices.isPagingEnabled = true
        scrollServices.showsHorizontalScrollIndicator = false
        scrollServices.contentSize = CGSize(width: view.frame.size.width * CGFloat(Service.allCases.count),
                                            height: scrollServices.frame.size.height)
        //
        scrollServices.translatesAutoresizingMaskIntoConstraints = false
        scrollServices.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 24).isActive = true
        scrollServices.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollServices.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollServices.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //
        let widthCard = view.frame.size.width // 40 - отступы карточки по бокам
        for (index, value) in Service.allCases.enumerated() {
            let frame = CGRect(x: CGFloat(index) * widthCard, y: 0, width: widthCard, height: 100)
            let serviceCard = ServiceCard(frame: frame, title: "\(value)", subtitle: value.rawValue)
            scrollServices.addSubview(serviceCard)
        }
    }
    
    private func createPageControl() {
        view.addSubview(pageControl)
        pageControl.numberOfPages = Service.allCases.count
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
//        pageControl.allowsContinuousInteraction = false
//        pageControl.accessibilityRespondsToUserInteraction = false
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        //
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: scrollServices.bottomAnchor).isActive = true
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createPastLinkButton() {
        view.addSubview(pastLinkButton)
        pastLinkButton.setTitleColor(.black, for: .normal)
        pastLinkButton.setTitle(AppLanguage.dictionary["pasteLinkHere"]!.stringValue, for: .normal)
        pastLinkButton.backgroundColor = .white
        pastLinkButton.layer.cornerRadius = 30
        pastLinkButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        pastLinkButton.addTarget(self, action: #selector(pastAction), for: .touchUpInside)
        //
        pastLinkButton.translatesAutoresizingMaskIntoConstraints = false
        pastLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pastLinkButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pastLinkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        pastLinkButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        pastLinkButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createInfoLabel() {
        view.addSubview(infoLabel)
        infoLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        infoLabel.textColor = .black
        infoLabel.backgroundColor = .white
        infoLabel.layer.cornerRadius = 4.0
        infoLabel.clipsToBounds = true
        infoLabel.alpha = 0
        //
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.bottomAnchor.constraint(equalTo: pastLinkButton.topAnchor, constant: -12).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createStackActionsButton() {
        view.addSubview(stackActionsButton)
        stackActionsButton.axis = .horizontal
        stackActionsButton.spacing = 6
        stackActionsButton.alignment = .center
        stackActionsButton.distribution = .fill
        //
        stackActionsButton.translatesAutoresizingMaskIntoConstraints = false
        stackActionsButton.topAnchor.constraint(equalTo: pastLinkButton.bottomAnchor, constant: 24).isActive = true
        stackActionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackActionsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    private func createBackButton() {
        stackActionsButton.addArrangedSubview(backButton)
        backButton.tintColor = .Violet_Dark_
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        //
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createCopyButton() {
        stackActionsButton.addArrangedSubview(copyButton)
        copyButton.tintColor = .Violet_Dark_
        copyButton.setImage(UIImage(named: "copy"), for: .normal)
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        //
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        copyButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createQrButton() {
        stackActionsButton.addArrangedSubview(qrButton)
        qrButton.tintColor = .Violet_Dark_
        qrButton.setImage(UIImage(named: "qr"), for: .normal)
        qrButton.addTarget(self, action: #selector(qrAction), for: .touchUpInside)
        //
        qrButton.translatesAutoresizingMaskIntoConstraints = false
        qrButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        qrButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createShareButton() {
        stackActionsButton.addArrangedSubview(shareButton)
        shareButton.tintColor = .Violet_Dark_
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        //
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createSaveButton() {
        stackActionsButton.addArrangedSubview(saveButton)
        saveButton.tintColor = .Violet_Dark_
        saveButton.setImage(UIImage(named: "markInArchive"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        //
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createArchiveButton() {
        view.addSubview(archiveButton)
        archiveButton.tintColor = .Violet_Dark_
        archiveButton.backgroundColor = .white.withAlphaComponent(0.25)
        archiveButton.setImage(UIImage(named: "archiveIcon"), for: .normal)
        archiveButton.tintColor = .Violet_Dark_
        archiveButton.layer.cornerRadius = 35
        archiveButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        archiveButton.clipsToBounds = true
        archiveButton.addTarget(self, action: #selector(openArchiveAction), for: .touchUpInside)
        //
        archiveButton.translatesAutoresizingMaskIntoConstraints = false
        archiveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        archiveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        archiveButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        archiveButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
}








import UIKit

extension StartViewController {

//    ///
//    @IBAction func copyAction(_ sender: UIButton) {
//        copiedShortLink()
//    }
    
//    ///
//    @IBAction func shareAaction(_ sender: UIButton) {
//        showControllerShare()
//    }
    
//    ///
//    @IBAction func showQRCode(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeModalViewController") as! QRCodeModalViewController
//        vc.linkForQRCode = StartViewController.shortLink
//        vc.modalPresentationStyle = .formSheet
//        present(vc, animated: true)
//    }
    
//    ///
//    @IBAction func openMenu(_ sender: Any?) {
//        /// проверка сосотояния покупок
//        let priceFullVersion = UserDefaults.standard.object(forKey: booplinkFullversionID)
//        let priceSupport = UserDefaults.standard.object(forKey: booplinkSupportID)
//        if priceFullVersion == nil && priceSupport == nil {
//            print("цены не получены")
//            let vc = storyboard?.instantiateViewController(withIdentifier: "MenuNoPriceViewController") as! MenuNoPriceViewController
//            navigationController?.pushViewController(vc, animated: true)
//        } else {
//            if StoreManager.isFullVersion() {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "MenuFullVersionViewController") as! MenuFullVersionViewController
//                navigationController?.pushViewController(vc, animated: true)
//            } else {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "MenuNoFullViewController") as! MenuNoFullViewController
//                navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//    }
    
    ///
//    @IBAction func backAction(_ sender: UIButton) {
//        viewSelf.linkLabel.text = AppLanguage.dictionary["pasteLinkHere"]!.stringValue
//        viewSelf.alphaStackActionButtons(valueAlpha: 0.0, duration: 0.2)
//        self.longLink = nil
//        StartViewController.shortLink = nil
//    }
    
    ///
//    @IBAction func saveLinkAction(_ sender: UIButton) {
//        viewSelf.animationSaveInArchive()
//        viewSelf.animationPulse()
//        addItemInArchive()
//    }
    
    ///
//    @IBAction func openArchiveAction(_ sender: Any?) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ArchiveViewController")
//        navigationController?.pushViewController(vc!, animated: true)
//    }
}
