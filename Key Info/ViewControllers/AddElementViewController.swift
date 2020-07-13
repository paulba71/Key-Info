//
//  AddElementViewController.swift
//  Key Info
//
//  Created by Paul Barnes on 29/06/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import UIKit

class AddElementViewController: UIViewController {

    var dataModel: DataModel = DataModel()
    var navigatedToImageSelection = false
    var navigatedToTypeSelection = false
    var imageSelected = "info.circle"
    var typeSelected = "Information"
    var viewMode = "add"    // Will be "add" or "edit"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Data model elements \(dataModel.model.count)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.navigatedToImageSelection) {
            print(imageSelected)
            imageView.image = UIImage(systemName: imageSelected)!
            navigatedToImageSelection = false
        }
        
        if(self.navigatedToTypeSelection) {
            // set the text
            print(typeSelected)
            self.typeValue.text = typeSelected
            // set the image too
            imageSelected = mapTypeToImage(type: typeSelected)
            imageView.image = UIImage(systemName: imageSelected)
            navigatedToTypeSelection = false
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var typeValue: UITextField!
    @IBOutlet weak var dataValue: UITextField!
    
    @IBAction func save(_ sender: Any) {
        if(typeValue.text
        == "" || dataValue.text == "") {
            // All data not supplied...
            print("Data not there")
        } else {
            // All ok - lets add to the data
            let item: InfoElement = InfoElement()
            item.data = dataValue.text!
            item.type = typeValue.text!
            item.image = imageSelected
            dataModel.add(element: item)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func changeImage(_ sender: Any) {
        // Open up the image viewer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "moveToImageSelector") {
            navigatedToImageSelection = true
            // Pass the viewcontroller to get the data back
            let destinationViewController = segue.destination as! ImageSelectorViewController
            destinationViewController.sourceController = self
        }
        
        if(segue.identifier == "moveToTypeSelector") {
            navigatedToTypeSelection = true
            // Pass the viewcontroller to get the data back
            let destinationViewController = segue.destination as! TypeChooserViewController
            destinationViewController.sourceController = self
        }
        
    }
    
    func mapTypeToImage(type: String) -> String {
        switch type {
        case "Car Registration", "Driving License Number":
            return "car"
        case "Postcode", "Eircode", "Zipcode" :
            if #available(iOS 14.0, *) {
                // use iOS 14-only feature
                return "location.viewfinder"
            } else {
                // handle older versions
                return "location.circle"
            }
        case "Passport Number", "SS Number", "PPS Number", "NI Number":
            return "person.crop.rectangle"
        case "TV License Number":
            return "tv"
        case "Insurance Policy No", "Pet License Number":
            return "doc.text.viewfinder"
        case "PIN", "Locker Code", "Alarm Code":
            return "number.square"
        case "Username", "Student ID", "Membership Number":
            return "person"
        case "Blood Type", "Medical No":
            return "staroflife"
        case "GP Phone Number":
            return "phone"
        case "WIFI Code":
            return "wifi"
        case "":
            return "info.circle"
            
        default:
            return "info.circle"
        }
    }
    
}
