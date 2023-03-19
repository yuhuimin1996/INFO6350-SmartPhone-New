//
//  ViewController.swift
//  MakeAPICall
//
//  Created by 于慧敏 on 3/18/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {
    
    var txtField: UITextField?
    
    var stockSymbol = ""
    
    
    @IBOutlet weak var txtStockSymbol: UITextField!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var lblStockPrice: UILabel!
    
    @IBOutlet weak var lblWebsite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getStockInfo(_ sender: Any) {
        guard let symbol = txtStockSymbol.text else {return}
        let url = "\(baseURL)\(symbol)?apikey=\(apiKey)"
        
        SwiftSpinner.show("Getting Stock Price for \(symbol)")
        
        AF.request(url).response { response in
            SwiftSpinner.hide()
            if response.error != nil {
                print("Error in response")
                return
            }
            guard let rawData = response.data else {return}
            guard let jsonArray = JSON(rawData).array else {return}
            guard let stock = jsonArray.first else {return}
            //print(stock)
            let companyName = stock["companyName"].stringValue
            let price = stock["price"].doubleValue
            let website = stock["website"].stringValue
            
            //print("Symbol = \(symbol)")
            //print("price = \(price)")
            //print("volume = \(volume)")
            self.lblCompanyName.text = "Company Name : \(companyName)"
            self.lblStockPrice.text = "Price : \(price) $"
            self.lblWebsite.text = "Website : \(website)"
        }
        
    }
    
}
