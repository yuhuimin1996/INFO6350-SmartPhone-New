//
//  UploadImageViewController.swift
//  InstaWithoutDBAndCloud
//
//  Created by 于慧敏 on 4/21/23.
//

import UIKit
import CoreLocation
import RealmSwift

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,CLLocationManagerDelegate {
    
    let realm = try! Realm()
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    var uploadProtocol : UploadImageProtocol?
    
    let locationManager = CLLocationManager()



    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    
    //
    @IBAction func uploadAction(_ sender: Any) {
        
        guard let image = imgView.image else {return}
        guard let location = lblLocation.text else {return}
        guard let title = txtTitle.text else {return}
    
    
        
        //after clicking the upload, upload to realmDB
        //add to realm DB
        let imageData: Data? = image.pngData()
                
        let imgData: InstaImageCelldata = InstaImageCelldata()
        imgData.title = title
        imgData.location = location
        imgData.Image = imageData
       
        // Add to the Realm
        do {
            try realm.write {
                realm.add(imgData, update: .modified)
            }
        } catch let error as NSError {
            print("Unable to add values to the DB " + error.localizedDescription)
        }

        
        uploadProtocol?.uploadedImageDelegate(img: image, locationImg: location, titleImg: title)
        
        //return to Home page after clicking the upload
        self.tabBarController?.selectedIndex = 0
    }
    
    
    //take picture
    @IBAction func takeAPictureAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Take a picture", message: "Something", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("User cancel")
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = image
        }
        
        picker.dismiss(animated: true)
    }
    

    
    //Get location
    @IBAction func getLocationAction(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        //let lat = location.coordinate.latitude
        //let lng = location.coordinate.longitude
        
//        lblLatitude.text = "Lat: \(lat)"
//        lblLongtitude.text = "Lng: \(lng)"
        
        getAddressFromLocation(location: location)
        

    }
    
    func getAddressFromLocation(location: CLLocation) {
        let geoEncoder = CLGeocoder()
        geoEncoder.reverseGeocodeLocation(location) { placemarks, error in

            if error != nil {
                print(error as Any)
                return
            }

            var address = ""
            guard let place = placemarks?.first else {return}
            if(place.name != nil) {
                address += place.name! + ", "
            }
            if(place.locality != nil) {
                address += place.locality! + ", "
            }
            if(place.subLocality != nil) {
                address += place.subLocality! + ", "
            }
            if(place.country != nil) {
                address += place.country! + ", "
            }
            if(place.postalCode != nil) {
                address += place.postalCode! + ", "
            }
            self.lblLocation.text = "\(address)"
        }
    }
    

    
    
}
