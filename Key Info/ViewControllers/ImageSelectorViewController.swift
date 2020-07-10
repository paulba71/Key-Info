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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageCell.image = images[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadImages()
    }
    
    func loadImages(){
        // Setup the images array...
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "multiply.circle.fill")!)
        images.append(UIImage(systemName: "paperplane.fill")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
        images.append(UIImage(systemName: "info.circle")!)
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
