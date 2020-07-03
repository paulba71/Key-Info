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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Data model elements \(dataModel.model.count)")
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
            var item: InfoElement = InfoElement()
            item.data = dataValue.text!
            item.type = typeValue.text!
            item.fontSize = 18
            item.image = nil
            dataModel.add(element: item)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
