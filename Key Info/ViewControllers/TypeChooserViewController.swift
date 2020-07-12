//
//  TypeChooserViewController.swift
//  Key Info
//
//  Created by Paul Barnes on 11/07/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import UIKit

class TypeChooserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var theTableView: UITableView!
    
    var sourceController: AddElementViewController = AddElementViewController()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTypesViewCell") as! InfoTypesViewCell
        let item = typesCollection[indexPath.row]
        cell.typeLabel.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Send the choice back and return to the previous screen
        sourceController.typeSelected = typesCollection[indexPath.row]
        self.navigationController?.popViewController(animated: true)
    }
    

    var typesCollection: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initTypes()
    }
    
    func initTypes() {
        typesCollection.append("Car Registration")
        typesCollection.append("Postcode")
        typesCollection.append("Eircode")
        typesCollection.append("Zipcode")
        typesCollection.append("Passport Number")
        typesCollection.append("Driving License Number")
        typesCollection.append("SS Number")
        typesCollection.append("PPS Number")
        typesCollection.append("NI Number")
        typesCollection.append("TV License Number")
        typesCollection.append("Insurance Policy No")
        typesCollection.append("PIN")
        typesCollection.append("Username")
        typesCollection.append("Blood Type")
        typesCollection.append("Medical No")
        typesCollection.append("Locker Code")
        typesCollection.append("GP Phone Number")
        typesCollection.append("Alarm Code")
        typesCollection.append("Student ID")
        typesCollection.append("Membership Number")
        typesCollection.append("Pet Licence Number")
        typesCollection.append("WIFI Code")
    }
    
}

