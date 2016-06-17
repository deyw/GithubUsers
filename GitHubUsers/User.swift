//
//  User.swift
//  GitHubUsers
//
//  Created by VLADISLAV TAIURSKIY on 15.06.16.
//  Copyright © 2016 VLADISLAV TAIURSKIY. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let userID: Int!
    let login: String!
    let profileURL: URL!
    var avatarURL: URL!
    var image: UIImage?
    init(userID: Int, login: String, profileURL: String, avatarURL: String) {
        self.userID = userID
        self.login = login
        self.profileURL = URL(string: profileURL)
        self.avatarURL = URL(string: avatarURL)
    }
    
       

}
