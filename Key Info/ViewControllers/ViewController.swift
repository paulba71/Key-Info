//
//  ViewController.swift
//  Key Info
//
//  Created by Paul Barnes on 28/06/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KeyInfoTableViewCell") as! KeyInfoTableViewCell
        cell.typeLabel.text = dataModel.model[indexPath.row].type
        cell.dataLabel.text = dataModel.model[indexPath.row].data
        return cell
    }
    

    
    var dataModel: DataModel = DataModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Back in the main view")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Back in the main view")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CreateNewElement") {
            print ("Moving to add")
            // The segue moves to a navcontroller which in turn moves to the view we want
            print("MOVING TO: \(segue.destination)")
            let navController = segue.destination as! UINavigationController
            let addViewController = navController.viewControllers[0] as! AddElementViewController
            addViewController.dataModel =  dataModel
        }
    }
}

