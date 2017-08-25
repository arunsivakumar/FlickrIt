//
//  PhotoDetailViewController.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

enum PhotoError: Error{
    case imageCreationError
}

class PhotoDetailViewController:UIViewController{
    
    
    //MARK:- Completion
    
    var imageCompletion:ImageCompletion = {_ in}
    
    
    //MARK:- Outlets
    
    @IBOutlet weak var photoImageView: GVRPanoramaView!
    
    //MARK:- Public API
    
    var photo:Photo!
    var photoStore:PhotoStore!
    
    
    //MARK:- Lifecycle
    
     override func viewDidLoad() {
        setUpVR()
        setUpCompletion()
        loadData()
     }
    
    //MARK:- Functions
    
    func setUpVR(){
        photoImageView.delegate = self
        photoImageView.isHidden = true
        
        photoImageView.enableCardboardButton = true
        photoImageView.enableFullscreenButton = true

        
    }
    
    func setUpCompletion(){
        imageCompletion = { [weak self] result in
            guard let _ = self else{ return }
            
            switch result{
                case .success(let image):
                    self?.photoImageView.load(image)
                case .failure(_):
                        break
            }
        }
    }
    
    func loadData(){
        photoStore.fetchImage(for: photo, completion: imageCompletion)
    }
}

//MARK:- GVRWidgetViewDelegate

extension PhotoDetailViewController: GVRWidgetViewDelegate {
    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!) {
        
        if content is UIImage {
            photoImageView.isHidden = false
            
        }
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!,
                    withErrorMessage errorMessage: String!)  {
    }
    
    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode) {
    }
    
    func widgetViewDidTap(_ widgetView: GVRWidgetView!) {
    }
}
