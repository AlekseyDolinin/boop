import UIKit

protocol ServicesContainerDelegate: AnyObject {
    func changeService(service: Service)
}

enum Service: String, CaseIterable {
    case Ulvis = "https://ulvis.net/*"
    case Click = "https://clck.ru/*"
    case Shortener = "https://goolnk.com/*"
}

final class ServicesContainer: UIView {
            
    weak var delegate: ServicesContainerDelegate?
    
    private let scrollServices = UIScrollView()
    private let pageControl = UIPageControl()
         
    private var widthCard: CGFloat = UIScreen.main.bounds.width
    private var currentIndexService = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setServises() {
        scrollServices.contentSize = CGSize(width: widthCard * CGFloat(Service.allCases.count),
                                            height: scrollServices.frame.size.height)
        for (index, value) in Service.allCases.enumerated() {
            let frame = CGRect(x: CGFloat(index) * widthCard, y: 0, width: widthCard, height: 100)
            let serviceCard = ServiceCard(frame: frame, title: "\(value)", subtitle: value.rawValue)
            scrollServices.addSubview(serviceCard)
        }
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let newIndex = sender.currentPage
        if newIndex < 0 { return }
        if newIndex != currentIndexService {
            currentIndexService = newIndex
//            selectedService = Service.allCases[currentIndexService]
            scrollServices.setContentOffset(CGPoint(x: CGFloat(currentIndexService) * widthCard, y: 0), animated: true)
            delegate?.changeService(service: Service.allCases[currentIndexService])
        }
    }
}


extension ServicesContainer: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newIndex = Int(floorf(Float(scrollView.contentOffset.x) / Float(widthCard)))
        if newIndex < 0 { return }
        if newIndex != currentIndexService {
            currentIndexService = newIndex
            pageControl.currentPage = currentIndexService
//            selectedService = Service.allCases[currentIndexService]
            delegate?.changeService(service: Service.allCases[currentIndexService])
        }
    }
}
    
    
extension ServicesContainer {
    
    private func createSubviews() {
        createScrollServices()
        createPageControl()
    }

    private func createScrollServices() {
        addSubview(scrollServices)
        scrollServices.backgroundColor = .clear
        scrollServices.alwaysBounceHorizontal = true
        scrollServices.delegate = self
        scrollServices.isPagingEnabled = true
        scrollServices.showsHorizontalScrollIndicator = false
        //
        scrollServices.translatesAutoresizingMaskIntoConstraints = false
        scrollServices.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollServices.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollServices.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollServices.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func createPageControl() {
        addSubview(pageControl)
        pageControl.numberOfPages = Service.allCases.count
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        //
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: scrollServices.bottomAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pageControl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
