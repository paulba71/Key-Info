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
        return dataModel.CountEntriesForUser(sectionIndex: section)
        //return dataModel.model.count
    }

    // Mark: - Tableview code
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionId=indexPath.first
        let element=dataModel.GetElementAt(x: indexPath.section, y: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KeyInfoTableViewCell") as! KeyInfoTableViewCell
        cell.typeLabel.text = element.type
        cell.dataLabel.text = element.data
        //cell.typeLabel.text = dataModel.model[indexPath.row].type
        //cell.dataLabel.text = dataModel.model[indexPath.row].data
        let image=UIImage(systemName: element.image)
        //let image=UIImage(systemName: dataModel.model[indexPath.row].image)
        
        cell.imageView?.image = image
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        cell.imageView?.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Swipe left to delete
        let completeAction = UIContextualAction(style: .destructive, title: "Delete") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            
            let refreshAlert = UIAlertController(title: "Delete", message: "Are You Sure?", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
                //print(self.dataModel.getAbsListIndex(section: indexPath.section, row: indexPath.row))
                self.dataModel.remove(at: self.dataModel.getAbsListIndex(section: indexPath.section, row: indexPath.row))
                tableView.reloadData()
                self.navigationController?.popToRootViewController(animated: true)
            }))

            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in

                refreshAlert .dismiss(animated: true, completion: nil)
            }))

            self.present(refreshAlert, animated: true, completion: nil)
            
            
            actionPerformed(true)
        }
        
        // Swipe left to Edit
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            
            let refreshAlert = UIAlertController(title: "Coming soon", message: "Edit is not implemented just yet. I am working on this and I'll post an update with this enabled very soon.", preferredStyle: UIAlertController.Style.alert)
            
            
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in

                refreshAlert .dismiss(animated: true, completion: nil)
            }))

            self.present(refreshAlert, animated: true, completion: nil)
            
            actionPerformed(true)
        }
        
        
        
        return UISwipeActionsConfiguration(actions: [completeAction, editAction/*, shareAction*/])
    }
    
    // Adding sections and headers to the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataModel.users.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "Paul"
        return dataModel.users[section]
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Swipe right to copy...
        let copyAction = UIContextualAction(style: .normal, title: "Copy") { (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            
            UIPasteboard.general.string = self.dataModel.model[indexPath.row].data
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [copyAction])
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIPasteboard.general.string = self.dataModel.model[indexPath.row].data
        let toastMessage = "Copied - \"\(self.dataModel.model[indexPath.row].data)\""
        self.showToast(message: toastMessage, font: .systemFont(ofSize: 22.0))
    }
    
    func reloadTable() {
        table.reloadData()
    }
 
    // Mark: - View management
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTable()
        for cell in table.visibleCells {
            cell.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    // Mark: - Actions
    @IBAction func sortTable(_ sender: Any) {
        dataModel.sortByType()
        reloadTable()
    }
    

    @IBAction func dummyFill(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Dummy Data", message: "Are You Sure - this will remove all existing entries and can't be undone?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            self.dataModel.setupDummyData()
            self.reloadTable()
            self.navigationController?.popToRootViewController(animated: true)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in

            refreshAlert .dismiss(animated: true, completion: nil)
        }))

        self.present(refreshAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func resetData(_ sender: Any) {
        // ask if the user wants to do this...
            
        let refreshAlert = UIAlertController(title: "Reset", message: "Are You Sure - this will remove all entries and can't be undone?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            self.dataModel.reset()
            self.reloadTable()
            self.navigationController?.popToRootViewController(animated: true)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in

            refreshAlert .dismiss(animated: true, completion: nil)
        }))

        self.present(refreshAlert, animated: true, completion: nil)
        
    }
    
    // Mark: - Segues
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

// Mark: - Extension to show toast
// Extension to show a toast like popup...
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

