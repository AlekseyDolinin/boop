import UIKit

final class MainVC: UIViewController {

    private var vm: MainVM!
    
    private let bgImage = UIImageView()
    private let menuButton = UIButton()
    private let servicesContainer = ServicesContainer()
    private let pastLinkButton = UIButton()
    private let infoLabel = PaddingLabel()
    private let archiveButton = UIButton()
    private let stackActionsButton = UIStackView()
    private let backButton = UIButton()
    private let copyButton = UIButton()
    private let qrButton = UIButton()
    private let shareButton = UIButton()
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        print("pastAction")
        if vm.shortLink != nil { return }
        guard let text = UIPasteboard.general.string else {
            print("text is empty")
            showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
            return
        }
        guard let encodeString = text.encodeUrl() else {
            print("error encodeString")
            return
        }
        // проверка вставлена ссылка или просто текст
        if let longLink = URL(string: encodeString), let scheme = longLink.scheme {
            if scheme != "https" && scheme != "http" {
                showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
                return
            }
            showMessage(text: AppLanguage.dictionary["pleaseWait"]!.stringValue)
            pastLinkButton.setTitle(UIPasteboard.general.string, for: .normal)
            pastLinkButton.isUserInteractionEnabled = false
            vm.createShortLink(longLink.absoluteString)
        } else {
            showMessage(text: AppLanguage.dictionary["notFoundLink"]!.stringValue)
            print("error link: \(text)")
        }
    }
}


extension MainVC: MainVMDelegate {

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
