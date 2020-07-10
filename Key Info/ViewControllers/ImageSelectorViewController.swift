//
//  ImageSelectorViewController.swift
//  Key Info
//
//  Created by Paul Barnes on 09/07/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import UIKit

class ImageSelectorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var images: [UIImage] = []
    var imageNames: [String] = []
    var sourceController: AddElementViewController = AddElementViewController()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageCell.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Item is selected - send it back to the main viewcontroller.
        let selectedImageName = imageNames[indexPath.row]
        sourceController.imageSelected = selectedImageName
        self.navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadImages()
    }
    
    func loadImages(){
        // Setup the images array...
        imageNames.append("info.circle")
        imageNames.append("multiply.circle.fill")
        imageNames.append("paperplane.fill")
        imageNames.append("car")
        imageNames.append("folder.circle.fill")
        imageNames.append("creditcard")
        imageNames.append("book")
        imageNames.append("book.fill")
        imageNames.append("house")
        imageNames.append("briefcase")
        imageNames.append("paperclip")
        imageNames.append("command")
        imageNames.append("rectangle.stack.person.crop")
        imageNames.append("bolt.fill")
        imageNames.append("bolt.circle.fill")
        imageNames.append("person.icloud")
        imageNames.append("message.circle")
        imageNames.append("text.bubble")
        imageNames.append("lock")
        imageNames.append("map")
        
        for imageName in imageNames {
            images.append(UIImage(systemName: imageName)!)
        }
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
