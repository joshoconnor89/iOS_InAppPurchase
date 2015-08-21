//
//  PurchaseViewController.swift
//  InAppDemo
//
//  Created by Neil Smyth on 11/10/14.
//  Copyright (c) 2014 Neil Smyth. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseViewController: UIViewController, SKPaymentTransactionObserver, SKProductsRequestDelegate {

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    
    var product: SKProduct?
    var productID = "UCSDExtensionInAppPurchasing"

    override func viewDidLoad() {
        super.viewDidLoad()
        buyButton.enabled = false
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        getProductInfo()

    }

    @IBAction func buyProduct(sender: AnyObject) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }

    func getProductInfo()
    {
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers: 
                    NSSet(objects: self.productID) as Set<NSObject>)
            request.delegate = self
            request.start()
        } else {
            productDescription.text = 
                "Please enable In App Purchase in Settings"
        }
    }

    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {

        var products = response.products

        if (products.count != 0) {
            product = products[0] as? SKProduct
            buyButton.enabled = true
            productTitle.text = product!.localizedTitle
            productDescription.text = product!.localizedDescription

        } else {
                productTitle.text = "Product not found"
        }

        products = response.invalidProductIdentifiers

        for product in products
        {
             println("Product not found: \(product)")
         }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
func paymentQueue(queue: SKPaymentQueue!, updatedDownloads downloads: [AnyObject]!) {

    for download in downloads as! [SKDownload]
    {
        switch download.downloadState {
            case SKDownloadState.Active:
                println("Download progress \(download.progress)")
                println("Download time = \(download.timeRemaining)")
                break
            case SKDownloadState.Finished:
                // Download is complete. Content file URL is at 
                // path referenced by download.contentURL. Move                       
                // it somewhere safe, unpack it and give the user 
                // access to it
                 break
            default:
                 break
        }
    }

}
    
    
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {

        for transaction in transactions as! [SKPaymentTransaction] {

            switch transaction.transactionState {

                case SKPaymentTransactionState.Purchased:
                    self.unlockFeature()                
             SKPaymentQueue.defaultQueue().finishTransaction(transaction)

                case SKPaymentTransactionState.Failed:
             SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                default:
                    break
            }
        }
    }

    func unlockFeature() {
        let appdelegate = UIApplication.sharedApplication().delegate 
                    as! AppDelegate

        appdelegate.homeViewController!.enableLevel2()
        buyButton.enabled = false
        productTitle.text = "Item has been purchased"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
