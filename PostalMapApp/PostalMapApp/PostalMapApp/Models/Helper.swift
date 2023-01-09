//
//  Helper.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/07.
//

import Foundation

import RealmSwift

class Helper{
    let realm = try! Realm()
    func saveDate(address: String,name:String,postalCode: String,chome: String,ban: String,tel: String,lat: Double,log: Double,tag: String){
        let newItem = User()
        newItem.address = address
        newItem.name = name
        newItem.postalCode = postalCode
        newItem.choume = chome
        newItem.ban = ban
        newItem.tel = tel
        newItem.lat = lat
        newItem.log = log
        newItem.tag = tag
        try! realm.write{
            realm.add(newItem)
        }
  
    }
    func deleteData(user:User){
 
        try! realm.write(){
            realm.delete(user)
        }
    }
}

