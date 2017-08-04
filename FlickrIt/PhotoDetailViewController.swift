//
//  PhotoDetailViewController.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class PhotoDetailViewController:UIViewController{
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo:Photo!
    
     override func viewDidLoad() {
        
        loadData()
        
     }
    
    func loadData(){
        self.photoImageView.kf.setImage(with: photo.url)
    }
}
