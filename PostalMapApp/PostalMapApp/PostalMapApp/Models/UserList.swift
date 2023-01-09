//
//  UserList.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/04.
//

import Foundation
import RealmSwift
class User: Object {
    @objc dynamic var address: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var postalCode: String = ""
    @objc dynamic var choume: String = ""
    @objc dynamic var ban: String = ""
    @objc dynamic var tel: String = ""
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var log: Double = 0.0
    @objc dynamic var tag: String = ""
        
        
    }
    
class Users: Object{
    let user = List<User>()
}
 
    

