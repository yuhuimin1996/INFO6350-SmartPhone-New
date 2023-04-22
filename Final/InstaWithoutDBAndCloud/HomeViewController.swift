//
//  HomeViewController.swift
//  InstaWithoutDBAndCloud
//
//  Created by 于慧敏 on 4/21/23.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UploadImageProtocol
{
    let realm = try! Realm()
    
    
    var images = [UIImage]()
    var locations = [String]()
    var imageTitles = [String]()
    
    @IBOutlet weak var tblView: UITableView!
    var uploadImageVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = navigationController
        uploadImageVC = navigationController?.tabBarController?.viewControllers?[1]
        print(Realm.Configuration.defaultConfiguration.fileURL!)

    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
        
        //注意：这里的cell后要写tableviewcell里定义的变量名
        cell.imageContainer.image = images[indexPath.row]
        cell.lblTitle?.text = imageTitles[indexPath.row]
        cell.lblLocation?.text = locations[indexPath.row]
        return cell
    }
    
    
    
    func uploadedImageDelegate(img: UIImage, locationImg: String, titleImg: String) {
        images.append(img)
        locations.append(locationImg)
        imageTitles.append(titleImg)
        
        tblView.reloadData()
    }
    


}
