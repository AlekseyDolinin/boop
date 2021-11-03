import UIKit
import StoreKit

class PriceManager: NSObject {
    
    var vc: UIViewController?
    var sm: StoreManager = StoreManager()
    
    func buyFullVersion(showAlertInViewController: UIViewController) {
        if !SKPaymentQueue.canMakePayments() {
            print("You can't make payments")
            return
        }
        self.vc = showAlertInViewController
        let productRequest = SKProductsRequest(productIdentifiers: ["ToDoList.FullVersion"])
        productRequest.delegate = self
        productRequest.start()
    }
    
    
    
    
    
}


extension PriceManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            let nf = NumberFormatter()
//            nf.numberStyle = NSNumberFormatterStyle.currency
            nf.locale = response.products[0].priceLocale
//            let price = String(response.products[0].price) + nf.
        }
    }
}
