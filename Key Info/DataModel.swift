//
//  DataModel.swift
//  Key Info
//
//  Created by Paul Barnes on 28/06/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import Foundation
import UIKit

class InfoElement: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    
    var type: String
    var data: String
    var image: String
    var user: String
    var name: String
    
    override init() {
        type = ""
        data = ""
        image = "info.circle"
        user = NSUserName()
        name = ""
    }
    
    init (theType: String, theData: String, theImage: String, theUser: String, theFontSize: Int?) {
        type = theType
        data = theData
        image = theImage
        user = theUser
        name = theUser
    }

    init (theType: String, theData: String, theImage: String, theUser: String, theFontSize: Int?, theName: String) {
        type = theType
        data = theData
        image = theImage
        user = theUser
        name = theName
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(type, forKey: "type")
        coder.encode(data, forKey: "data")
        coder.encode(image, forKey: "image")
        coder.encode(name, forKey: "user")
        coder.encode(name, forKey: "name")
    }
    
    required init?(coder: NSCoder) {
        self.data = coder.decodeObject(forKey: "data") as! String
        self.type = coder.decodeObject(forKey: "type") as! String
        self.image = coder.decodeObject(forKey: "image") as! String
        if coder.containsValue(forKey: "user") {
            self.user = coder.decodeObject(forKey: "user") as! String
        }
        else {
            self.user=NSUserName()
        }
        //self.name = coder.decodeObject(forKey: "name") as! String
        self.name=""
        //self.image = "info.circle"
        if self.user == "" {
            self.user=NSUserName()
        }
    }
}

class DataModel {
    var model: [InfoElement] = []
    let defaults = UserDefaults.standard
    var users: [String] = []
    
    
    init() {
        // if there is no model stored - intiialise the default one
        let startingElement: InfoElement = initialModel()
        model = [startingElement]
        // Load the model from storage
        load()
        /*print("---------------------------------")
        print("Settings")
        print("---------------------------------")
        print(Array(UserDefaults.standard.dictionaryRepresentation()))
        print("---------------------------------")*/
    }
    
    func initialModel () -> InfoElement {
        let user = NSUserName()
        let initialElement: InfoElement = InfoElement (theType: "Example element", theData: "Item Value", theImage: "info.circle", theUser: user, theFontSize: 18, theName: "label")
        return initialElement
    }
    
    func add(element: InfoElement)
    {
        if element.data == "" || element.type == ""  {
            print ("ERROR - can't add to datamodel")
        } else {
            // Check to see if the model only has the original element
            if(model.count == 1) {
                if model[0].data == "Item Value" && model[0].type == "Example element" {
                    model.remove(at: 0)
                    
                }
            }
            model.append(element)
            // Save the data model to storage
            save()
            // Rebuild the users list...
            BuildUsersList()
        }
    }
    
    func remove(at: Int) {
        model.remove(at: at)
        if model.count == 0 {
            let startingElement: InfoElement = initialModel()
            model = [startingElement]
        }
        save()
    }

    /*
    func remove(section: Int, row: Int) {
        //model.remove(at: at)
        let user = users[section] // can be "" so need to handle that
        var absoluteIndex = 0
        var index = 0
        for element in model {
            if element.user == user {
                index += 1
                if index == row {
                    // remove element
                    return
                }
            }
            absoluteIndex += 1
        }
        if model.count == 0 {
            let startingElement: InfoElement = initialModel()
            model = [startingElement]
        }
        save()
    } */

    func getAbsListIndex (section: Int, row: Int) -> Int {
        let user = users[section] // can be "" so need to handle that
        var absoluteIndex = 0
        var index = 0
        for element in model {
            if element.user == user {
                if index == row {
                    // remove element
                    return absoluteIndex
                }
                index += 1
            }
            absoluteIndex += 1
        }
        return -1;
    }
    
    func setupDummyData() {
        model.removeAll()
        var dummyElement: InfoElement = InfoElement (theType: "Example element1", theData: "Item Value", theImage: "info.circle", theUser: "Mary", theFontSize: 18, theName: "Mary")
        add(element: dummyElement)
        save()
        dummyElement = InfoElement (theType: "Passport", theData: "PDH35345XR", theImage: "book.fill", theUser: "Mary", theFontSize: 18, theName: "Mary")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Driving License", theData: "DRV10173854", theImage: "briefcase", theUser: "Mary", theFontSize: 18, theName: "Mary")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Car Reg", theData: "192D82357", theImage: "car", theUser: "Mary", theFontSize: 18, theName: "Mary")
        add(element: dummyElement)
        
        dummyElement = InfoElement (theType: "Example element", theData: "Item Value", theImage: "info.circle", theUser: "Peter", theFontSize: 18, theName: "Peter")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Passport", theData: "PDH35345XR", theImage: "book.fill", theUser: "Peter", theFontSize: 18, theName: "Peter")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Driving License", theData: "DRV10173854", theImage: "briefcase", theUser: "Peter", theFontSize: 18, theName: "Peter")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Car Reg", theData: "192D82357", theImage: "car", theUser: "Peter", theFontSize: 18, theName: "Peter")
        add(element: dummyElement)
        
        dummyElement = InfoElement (theType: "Example element", theData: "Item Value", theImage: "info.circle", theUser: "Aoife", theFontSize: 18, theName: "Aoife")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Passport", theData: "PDH35345XR", theImage: "book.fill", theUser: "Aoife", theFontSize: 18, theName: "Aoife")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Driving License", theData: "DRV10173854", theImage: "briefcase", theUser: "Aoife", theFontSize: 18, theName: "Aoife")
        add(element: dummyElement)
        dummyElement = InfoElement (theType: "Car Reg", theData: "192D82357", theImage: "car", theUser: "Aoife", theFontSize: 18, theName: "Aoife")
        add(element: dummyElement)
        save()
    }
    
    
    func load() {
        // Load the model from storage
        guard let modelData = defaults.object(forKey: "InfoData") as? Data else {
            return
        }
        // Use NSKeyedUnarchiver to convert Data / NSData back to Player object
        guard let localModel = NSKeyedUnarchiver.unarchiveObject(with: modelData) as? [InfoElement] else {
            return
        }
        self.model = localModel
        BuildUsersList()
    }
    
    func BuildUsersList(){
        var currentUserName=NSUserName()
        users.removeAll()
        for element in self.model {
            if element.user == ""{
                currentUserName = "Me"
            }
            else{
                currentUserName = element.user
            }
            if !users.contains(currentUserName){
                users.append(currentUserName)
            }
        }
        //print(element.user)
    }
    
    func CountEntriesForUser(sectionIndex: Int) -> Int{
        let userName=self.users[sectionIndex]
        var counter = 0
        for element in self.model {
            if(element.user == userName) {
                counter+=1
            }
        }
        return counter
    }
    
    func GetElementAt(x: Int, y: Int) -> InfoElement{
        let defaultElement = InfoElement()
        let user=users[x]
        //print(user)
        var counter=0
        for element in self.model {
            if element.user==user {
                if counter==y{
                    return element
                }
                else {
                    counter+=1
                }
            }
        }
        return defaultElement
    }

    // Add the capability to edit an element in a particular position...
    func Edit(position: Int, element: InfoElement){
        model.remove(at: position)
        model.insert(element, at: position)
    }
    
    func save() {
        // Save the model to disk
        print("Saving data to settings storage")
        let modelData = try! NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: true)
        UserDefaults.standard.set(modelData, forKey: "InfoData")
    }
    
    func sortByType () {
        model.sort {
            $0.type.lowercased() < $1.type.lowercased()
        }
        save()
    }
    
    func reset() {
        let startingElement: InfoElement = initialModel()
        model.removeAll()
        model = [startingElement]
        save()
        // Rebuild the users list...
        BuildUsersList()
    }
}

extension UserDefaults {
    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }

    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
}
