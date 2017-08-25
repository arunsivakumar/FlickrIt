//
//  ViewController.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
     //MARK:- Public API
    var photoStore:PhotoStore!
    
     //MARK:- Variables
    
    let photoDataSource = PhotoDataSource()
    private var photoCompletion: PhotoCompletion = {_ in }
    
    //MARK:- Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    
     //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = photoDataSource
        
        setUpCompletion()
        loadData()
    }
    
     //MARK:- Functions
    
    func loadData(){
        photoStore.fetchPhotos(completion: photoCompletion)
        
    }
    
    func setUpCompletion(){
        
        photoCompletion = { [weak self] (result) in
            switch result{
            case let .success(photos):
                self?.photoDataSource.photos = photos
            case .failure(_):
                self?.photoDataSource.photos.removeAll()
            }
            self?.collectionView.reloadData()
        }
    }
}

//MARK:- CollectionView Delegate

extension PhotosViewController:UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cells = 1
        let width = (self.view.frame.width / CGFloat(cells))
        let height = width / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photo = photoDataSource.photos[indexPath.row]
//    }
}

//MARK:- Navigation

extension PhotosViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let vc =
                    segue.destination as! PhotoDetailViewController
                vc.photo = photo
                vc.photoStore = photoStore
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }

}
