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
    var imageSelected = "info.circle"
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
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
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
        
    }
    
}
