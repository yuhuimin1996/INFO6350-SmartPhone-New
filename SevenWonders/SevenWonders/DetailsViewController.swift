//
//  DetailsViewController.swift
//  SevenWonders
//
//  Created by 于慧敏 on 3/18/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var txtDetails: UITextView!
    
    var wonder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtDetails.text = "This is \(wonder)"
    }
    


}
