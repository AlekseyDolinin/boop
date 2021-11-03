import UIKit
import StoreKit

let nTransactionComplate: NSNotification.Name = NSNotification.Name(rawValue: "nTransactionComplate")

class StoreManager: NSObject {
    
    class func isFullVersion() -> Bool {
        print("is full version: \(UserDefaults.standard.bool(forKey: "FullVersion"))")
        return UserDefaults.standard.bool(forKey: "FullVersion")
    }
    
    /// запись после покупки проверсии
    class func didBuyFullVersion() {
        UserDefaults.standard.set(true, forKey: "FullVersion")
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: nTransactionComplate, object: nil)
    }
    
    func buyInApp(inAppID: String) {
        if !SKPaymentQueue.canMakePayments() {
            print("You can't make payments")
            return
        }
        let request = SKProductsRequest(productIdentifiers: [inAppID])
        request.delegate = self
        request.start()
    }
    
    func restorePurchase() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


extension StoreManager: SKProductsRequestDelegate {
    ///
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            let product = response.products[0]
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
        print("invalid ID: \(response.invalidProductIdentifiers)")
    }
}

extension StoreManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            
            print("State transaction product \(transaction.payment.productIdentifier): \(transaction.transactionState)")
            
            switch transaction.transactionState {
            case .purchasing:
                print("purchasing")
            case .purchased:
                queue.finishTransaction(transaction)
                StoreManager.didBuyFullVersion()
            case .failed:
                queue.finishTransaction(transaction)
            case .restored:
                queue.finishTransaction(transaction)
                StoreManager.didBuyFullVersion()
            case .deferred:
                print("deferred")
            default:
                print("Обработать: \(transaction.transactionState)")
                break
            }
        }
    }
}
