//
//  GetGithubUsers.swift
//  GitHubUsers
//
//  Created by VLADISLAV TAIURSKIY on 15.06.16.
//  Copyright © 2016 VLADISLAV TAIURSKIY. All rights reserved.
//

import UIKit

class GetGithubUsers {
    
    let baseURL: String = "https://api.github.com/users"
    
    
    static let sharedInstance = GetGithubUsers()
    
    
    func getUsers(since: Int, perPage: Int = 100, completionHandler:([User]) -> ()) {
        
        let url = self.urlWithParams(since: since, perPage: perPage)
        let request = URLRequest(url: url as URL)
        let session = URLSession.shared()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            
            guard let _:NSData = data, let _:URLResponse = response where error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            do {
                
                let json: [NSDictionary] = try(JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! [NSDictionary]
                
                
                var userData = [User]()
                
                for dict in json as! [[String: AnyObject]] {
                    
                    let user = User(userID: dict["id"] as! Int,
                                    login: dict["login"] as! String,
                                    profileURL: dict["html_url"] as! String,
                                    avatarURL: dict["avatar_url"] as! String)
                    
                    userData.append(user)
                    
                }
                
                
                DispatchQueue.main.async(execute: {
                    completionHandler(userData)
                })
                
                
                
            } catch let err as NSError {
                print(err.localizedDescription)
            }
                       
            
        }
        task.resume()
    }
    
    func urlWithParams(since: Int, perPage: Int) -> NSURL {
        return URL(string: "\(self.baseURL)?per_page=\(perPage)&since=\(since)")!
    }
}
