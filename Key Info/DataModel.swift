//
//  DataModel.swift
//  Key Info
//
//  Created by Paul Barnes on 28/06/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import Foundation
import UIKit

struct InfoElement {
    var type: String
    var data: String
    var image: UIImage?
    var fontSize: Int
    
    init() {
        type = ""
        data = ""
        image = nil
        fontSize = 18
    }
    
    init (theType: String, theData: String, theImage: UIImage?, theFontSize: Int) {
        type = theType
        data = theData
        image = theImage
        fontSize = theFontSize
    }
}

class DataModel {
    var model: [InfoElement] = []
    
    init() {
        // Load the model from storage
        
        // if there is no model stored - load the default one
        let startingElement: InfoElement = initialModel()
        model = [startingElement]
    }
    
    func loadModel () -> Bool {
        return true;
    }
    
    func initialModel () -> InfoElement {
        let initialElement: InfoElement = InfoElement(theType: "Example element", theData: "Item Value", theImage: nil, theFontSize: 18)
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
                    model.append(element)
                    // Save the data model to storage
                }
            }
        }
    }
}
