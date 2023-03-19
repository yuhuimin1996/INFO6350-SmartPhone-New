//
//  ViewController.swift
//  SevenWonders
//
//  Created by 于慧敏 on 3/18/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let wonders = ["Machu Picchu, Peru", "The Great Wall, China", "Taj Mahal, India", "The Colosseum, Italy", "Petra, Jordan", "Christ the Redeemer, Brazil", "Chichén Itzá, Mexico"]
    
    var wonder = ""
    

    @IBOutlet weak var tblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wonders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
        
        cell.imgContainer.image = UIImage(named: wonders[indexPath.row])
        cell.lblImage.text = wonders[indexPath.row]
        
        return cell
    }
    
    @IBAction func goToSecondVCAction(_ sender: Any) {
        performSegue(withIdentifier: "segueSecondVC", sender: self)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblView {
            wonder = wonders[indexPath.row]
            goToSecondVCAction(self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSecondVC" {
            let secondVC = segue.destination as! DetailsViewController
            secondVC.wonder = wonder
        }
    }
    




}

