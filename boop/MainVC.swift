import UIKit

final class MainVC: UIViewController {
    
    private var vm: MainVM!
    
    private let bgImage = UIImageView()
    private let menuButton = UIButton()
    private let servicesContainer = ServicesContainer()
    private let pastLinkButton = UIButton()
    private let infoLabel = PaddingLabel()
    private let archiveButton = UIButton()
    private let stackActionsButtons = UIStackView()
    private let backButton = UIButton()
    private let copyButton = UIButton()
    private let qrButton = UIButton()
    private let shareButton = UIButton()
    private let saveButton = UIButton()
    
    private var shareController: UIActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = MainVM()
        vm.delegate = self
        servicesContainer.delegate = self
        AppLanguage.setLanguage()
        createSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        servicesContainer.setServises()
    }

    //
    func showMessage(text: String, autoHide: Bool = true) {
        infoLabel.text = text
        UIView.animate(withDuration: 0.1, animations: {
            self.infoLabel.alpha = 1
        }) { (true) in
            if autoHide == false { return }
            UIView.animate(withDuration: 0.1, delay: 2.0, options: .curveLinear, animations: {
                self.infoLabel.alpha = 0
            }, completion: { (true) in
                print("hide message")
            })
        }
    }
    
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
        pastLinkButton.isUserInteractionEnabled = true
        pastLinkButton.setTitle(AppLanguage.dictionary["pasteLinkHere"]!.stringValue, for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.stackActionsButtons.alpha = 0
        }
        vm.shortLink = nil
    }
    
    @objc func copyAction(_ sender: UIButton) {
        print("copyAction")
        vm.pasteboard.string = vm.shortLink
        showMessage(text: AppLanguage.dictionary["linkCopied"]!.stringValue)
    }
    
    @objc func qrAction(_ sender: UIButton) {
        present(QRCodeModalVC(shortLink: vm.shortLink), animated: true)
    }
    
    @objc func shareAction(_ sender: UIButton) {
        print("shareAction")
        shareController = UIActivityViewController(activityItems: [vm.shortLink as Any], 
                                                   applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            bool == true ? print("it is done!") : print("error send")
        }
        present(shareController, animated: true)
    }
    
    @objc func saveAction(_ sender: UIButton) {
        print("saveAction")
//        Archive.addItemInArchive(longLink: self.longLink)
    }
    
    @objc func pastAction(_ sender: UIButton) {
        print("pastAction")
        if vm.shortLink != nil { return }
        guard let link = UIPasteboard.general.string else {
            print("text is empty")
            showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
            return
        }
        guard let encodeString = link.encodeUrl() else {
            print("error encodeString")
            return
        }
        // проверка вставлена ссылка или просто текст
        if let longLink = URL(string: encodeString), let scheme = longLink.scheme {
            if scheme != "https" && scheme != "http" {
                showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
                return
            }
            showMessage(text: AppLanguage.dictionary["pleaseWait"]!.stringValue, autoHide: false)
            pastLinkButton.setTitle(UIPasteboard.general.string, for: .normal)
            pastLinkButton.isUserInteractionEnabled = false
            vm.createShortLink(link: link)
        } else {
            showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
            print("error link: \(link)")
        }
    }
}


extension MainVC: MainVMDelegate {

    func getShortLinkSuccess() {
        DispatchQueue.main.async {
            print("getShortLinkSuccess: \(self.vm.shortLink)")
            self.pastLinkButton.setTitle(self.vm.shortLink, for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.stackActionsButtons.alpha = 1
                self.infoLabel.alpha = 0
            }
        }
    }
}


extension MainVC: ServicesContainerDelegate {
    
    func changeService(service: Service) {
        vm.selectedService = service
    }
}


extension MainVC {
    
    private func createSubviews() {
        createBGImage()
        createMenuButton()
        createServicesContainer()
        createPastLinkButton()
        createInfoLabel()
        createStackActionsButtons()
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
    
    private func createServicesContainer() {
        view.addSubview(servicesContainer)
        //
        servicesContainer.translatesAutoresizingMaskIntoConstraints = false
        servicesContainer.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 24).isActive = true
        servicesContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        servicesContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
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
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.text = "Not Found Link \n(Please, copy url to clipboard)"
        //
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.bottomAnchor.constraint(equalTo: pastLinkButton.topAnchor, constant: -12).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func createStackActionsButtons() {
        view.addSubview(stackActionsButtons)
        stackActionsButtons.axis = .horizontal
        stackActionsButtons.spacing = 6
        stackActionsButtons.alignment = .center
        stackActionsButtons.distribution = .fill
        stackActionsButtons.alpha = 0
        //
        stackActionsButtons.translatesAutoresizingMaskIntoConstraints = false
        stackActionsButtons.topAnchor.constraint(equalTo: pastLinkButton.bottomAnchor, constant: 24).isActive = true
        stackActionsButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackActionsButtons.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    private func createBackButton() {
        stackActionsButtons.addArrangedSubview(backButton)
        backButton.tintColor = .Violet_Dark_
        let configuration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let image = UIImage(systemName: "arrow.turn.up.left", withConfiguration: configuration)
        backButton.setImage(image, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        //
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createCopyButton() {
        stackActionsButtons.addArrangedSubview(copyButton)
        copyButton.tintColor = .Violet_Dark_
        let configuration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let image = UIImage(systemName: "doc.on.doc", withConfiguration: configuration)
        copyButton.setImage(image, for: .normal)
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        //
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        copyButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createQrButton() {
        stackActionsButtons.addArrangedSubview(qrButton)
        qrButton.tintColor = .Violet_Dark_
        let configuration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let image = UIImage(systemName: "qrcode", withConfiguration: configuration)
        qrButton.setImage(image, for: .normal)
        qrButton.addTarget(self, action: #selector(qrAction), for: .touchUpInside)
        //
        qrButton.translatesAutoresizingMaskIntoConstraints = false
        qrButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        qrButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createShareButton() {
        stackActionsButtons.addArrangedSubview(shareButton)
        shareButton.tintColor = .Violet_Dark_
        let configuration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: configuration)
        shareButton.setImage(image, for: .normal)
        shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        //
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createSaveButton() {
        stackActionsButtons.addArrangedSubview(saveButton)
        saveButton.tintColor = .Violet_Dark_
        let configuration = UIImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let image = UIImage(systemName: "bookmark", withConfiguration: configuration)
        saveButton.setImage(image, for: .normal)
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
        let configuration = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
        let image = UIImage(systemName: "archivebox", withConfiguration: configuration)
        archiveButton.setImage(image, for: .normal)
        archiveButton.tintColor = .Violet_Dark_
        archiveButton.layer.cornerRadius = 35
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
