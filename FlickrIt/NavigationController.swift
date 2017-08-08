//
//  NavigationController.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/7/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation


import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUI(){
        
//        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: Constants.defaultFontNavigation, size: Constants.defaultFontSizeNavigation)!,
            NSForegroundColorAttributeName : UIColor.white
        ]
        

//        self.navigationBar.isTranslucent = true        
        self.navigationBar.backgroundColor = Constants.navBarColor
                
    }
}
