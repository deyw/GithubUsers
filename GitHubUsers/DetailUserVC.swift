//
//  DetailUserVC.swift
//  GitHubUsers
//
//  Created by VLADISLAV TAIURSKIY on 16.06.16.
//  Copyright © 2016 VLADISLAV TAIURSKIY. All rights reserved.
//

import UIKit

class DetailUserVC: UIViewController {   
    
    
    var profileImage: UIImageView?
    var resizeableImage = UIImageView(frame: CGRect(x: 0, y: 120, width: 400, height: 400))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white()
     
       
        navigationItem.title = "Profile Image"
        self.resizeableImage.image = profileImage?.image
        view.addSubview(resizeableImage)

        
    }
    



}
