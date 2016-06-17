//
//  ViewController.swift
//  GitHubUsers
//
//  Created by VLADISLAV TAIURSKIY on 15.06.16.
//  Copyright © 2016 VLADISLAV TAIURSKIY. All rights reserved.
//

import UIKit

class UserTableVC: UITableViewController {
    
    var users: [User] = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetGithubUsers.sharedInstance.getUsers(since: 1) { [unowned self] (userData)  in
            self.users = userData
            self.tableView.reloadData()
        }
        
        tableView.rowHeight = 100
        
        navigationItem.title = "GitHub Users"
        tableView.register(UserCell.self, forCellReuseIdentifier: "cellID")
    }
    
    
  
    override func viewDidAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! UserCell
        
        let user = self.users[indexPath.row]
        cell.textLabel?.text = user.login
        cell.detailTextLabel?.text = user.profileURL.absoluteString
        
        
        if user.image == nil {
            cell.imageView?.image = nil
            
            if let url = user.avatarURL {
                DispatchQueue.global(attributes: .qosDefault).async(execute: {
                    let contentsOfURL = NSData(contentsOf: url)
                    DispatchQueue.main.async(execute: {
                        if  url == user.avatarURL {
                            if let imageData = contentsOfURL {
                                user.image = UIImage(data: imageData as Data)
                                cell.imageView?.image = user.image
                                
                                tableView.reloadRows(at: [indexPath], with: .fade)
                            }
                        } else {
                            print("error fetch image")
                        }
                    })
                })
                
            }
        } else {
            cell.imageView?.image = user.image
            
        }
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        cell.imageView?.addGestureRecognizer(tapGesture)
        cell.imageView?.isUserInteractionEnabled = true
        
        return cell
    }
    
    
    
    func tapAvatar(sender: UITapGestureRecognizer? = nil) {
        let controller = DetailUserVC()
        
        let avatarImage: UIImageView = sender?.view as! UIImageView
        avatarImage.gestureRecognizers?.removeAll()
        controller.profileImage = avatarImage
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }   
    
    
    
    
    
}

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

