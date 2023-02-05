//
//  AppDelegate.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/04.
//

import UIKit
import RealmSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        _ = try! Realm(configuration: config)
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        return true
    }
}
