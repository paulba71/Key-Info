//
//  ViewController.swift
//  Key Info
//
//  Created by Paul Barnes on 28/06/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataModel: DataModel = DataModel()
    var table: UITableView = UITableView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        table = tableView
        return dataModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KeyInfoTableViewCell") as! KeyInfoTableViewCell
        cell.typeLabel.text = dataModel.model[indexPath.row].type
        cell.dataLabel.text = dataModel.model[indexPath.row].data
        let image=UIImage(systemName: dataModel.model[indexPath.row].image)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.image = image
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .destructive, title: "Delete") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            
            self.dataModel.remove(at: indexPath.row)
            tableView.reloadData()
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func reloadTable() {
        table.reloadData()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Back in the main view")
        reloadTable()
        for cell in table.visibleCells {
            cell.imageView?.contentMode = .scaleAspectFill
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CreateNewElement") {
            // The segue moves to a navcontroller which in turn moves to the view we want
            print("MOVING TO: \(segue.destination)")
            let navController = segue.destination as! UINavigationController
            let addViewController = navController.viewControllers[0] as! AddElementViewController
            addViewController.dataModel =  dataModel
        }
    }
}

