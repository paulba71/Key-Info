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
    //var image: UIImage?
    //var fontSize: Int
    
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
        name = ""
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
        coder.encode(user, forKey: "user")
        coder.encode(name, forKey: "name")
    }
    
    required init?(coder: NSCoder) {
        self.data = coder.decodeObject(forKey: "data") as! String
        self.type = coder.decodeObject(forKey: "type") as! String
        self.image = coder.decodeObject(forKey: "image") as! String
        self.user = coder.decodeObject(forKey: "user") as! String
        self.name = coder.decodeObject(forKey: "name") as! String
        //self.image = "info.circle"
    }
}

class DataModel {
    var model: [InfoElement] = []
    let defaults = UserDefaults.standard
    
    init() {
        // if there is no model stored - intiialise the default one
        let startingElement: InfoElement = initialModel()
        model = [startingElement]
        // Load the model from storage
        load()
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
        //AddUserData()
    }

    //func AddUserData() {
        // User field was added later - this method will populate it
    //    let user = NSUserName()
    //    foreach (element in model) {
    //        print(element.user, " : ", user)
    //    }
    //}
    
    func save() {
        // Save the model to disk
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
        model = [startingElement]
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
