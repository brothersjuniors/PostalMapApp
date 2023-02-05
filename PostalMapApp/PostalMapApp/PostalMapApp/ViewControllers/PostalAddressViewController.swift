//
//  PostalAddressViewController.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/04.
//

import UIKit
import CoreLocation
import RealmSwift
class PostalAddressViewController: UIViewController {
    private var lat: String = ""
    private var log: String = ""
    var reLat: Double = 0.0
    var reLog: Double = 0.0
    let realm = try! Realm()
    private var addressString = ""
 
    @IBOutlet var longtap: UILongPressGestureRecognizer!
    
    @IBOutlet weak var tourokuButton: UIButton!
    @IBOutlet weak var postal: UITextField!
    @IBOutlet weak var postalLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var choLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var chomeTextField: UITextField!
    @IBOutlet weak var banTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var mnNumberTextField: UITextField!
    @IBOutlet weak var registerNumber: UILabel!
    var data: Results<User>!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //✳️枠外タッチでキーボードが隠す処理①
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        //✳️テキストフィールドで使用するkeyboardの設定
        postal.keyboardType = .numberPad
        chomeTextField.keyboardType = .numberPad
        banTextField.keyboardType = .numberPad
        telTextField.keyboardType = .numberPad
        mnNumberTextField.keyboardType = .numberPad
        data = realm.objects(User.self)
        
    }
    
    //✳️キーボードを隠す処理②
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    //✳️郵便番号から住所を表示
    @IBAction func convertButton(_ sender: Any) {
        let postalCode = postal.text!
        convertAddress(from: postalCode) { [self] address, error in
            if let error = error {
                print(error)
                addressLabel.text = "正しい郵便番号を入力してください"
                return
            }
            
            self.addressLabel.text = address!.administrativeArea + address!.locality + address!.subLocality
            self.addressString = self.addressLabel.text!
            postalLabel.text = postal.text!
            prefectureLabel.text = address?.administrativeArea
            cityLabel.text = address?.locality
            choLabel.text = address?.subLocality
            postal.text = ""
        }
    }
    //✳️郵便番号から緯度経度と住所変換
    func convertAddress(from postalCode: String, completion: @escaping (Address?, Error?) -> Void) {
        CLGeocoder().geocodeAddressString(postalCode) { (placemarks, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            if let placemark = placemarks?.first {
                let location = CLLocation(
                    latitude: (placemark.location?.coordinate.latitude)!,
                    longitude: (placemark.location?.coordinate.longitude)!
                )
                CLGeocoder().reverseGeocodeLocation(location) { [self] placemarks, error in
                    guard let placemark = placemarks?.first, error == nil else {
                        completion(nil, error)
                        return
                    }
                    //✳️経度
                    lat = String(location.coordinate.latitude)
                    print(lat)
                    //✳️緯度
                    log = String(location.coordinate.longitude)
                    print(log)
                    var address: Address = Address()
                    address.administrativeArea = placemark.administrativeArea!
                    address.locality = placemark.locality!
                    address.subLocality = placemark.subLocality!
                    completion(address, nil)
                }
            }
        }
    }
    //✳️n丁目とn番地を取得した上で再度緯度経度を取得して、realmに保存する
    @IBAction func registerButton(_ sender: Any) {
        
        let chomeString = chomeTextField.text!
        let banString = banTextField.text!
        let address = addressString+chomeString+"-"+banString
        CLGeocoder().geocodeAddressString(address) { [self] placemarks, error in
            if let lat = placemarks?.first?.location?.coordinate.latitude {
                reLat = lat
            }
            if let log = placemarks?.first?.location?.coordinate.longitude {
                reLog = log
            }
            Helper().saveDate(address: address,name: nameTextField.text!, postalCode: postalLabel.text!, chome: chomeTextField.text!, ban: banTextField.text!, tel: telTextField.text!, lat: reLat, log: reLog, tag: mnNumberTextField.text!)
          
            postal.text = ""
            chomeTextField.text = ""
            banTextField.text = ""
            telTextField.text = ""
            mnNumberTextField.text = ""
            nameTextField.text = ""
            registerNumber.text = String(data.count)
        }
    }

    }
