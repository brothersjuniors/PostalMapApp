//
//  MapViewController.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/09.
//

import UIKit
import MapKit
import RealmSwift
import CoreLocation
class MapViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate{
    var data: Results<User>!
    var addressString = ""
    let realm = try! Realm()
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //現在地表示メソッド①
        locationManager.delegate = self
        //現在地表示メソッド②
        locationManager.startUpdatingLocation()  // 位置情報更新を指示
           // アプリの使用中のみ位置情報サービスの利用許可を求める
           locationManager.requestWhenInUseAuthorization()
   
        //ユーザの向きに合わせる
        mapView.userTrackingMode = .follow
        //枠外タッチでキーボードを閉じる
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        data = realm.objects(User.self)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func textView(_ textView: UITextView,editMenuForTextIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu?{
        return nil
    }
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ){
        
        
    }
    @IBAction func longPressTapped(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
        } else if sender.state == .ended {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            let tapPoint = sender.location(in: view)
            let center = mapView.convert( tapPoint, toCoordinateFrom: view)
            let lat = center.latitude
            let log = center.longitude
            convert(lat: lat, log: log)
        }
    }
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude:lat,longitude: log)
        geocoder.reverseGeocodeLocation(location) { [self] placeMark, error in
            if let placeMark = placeMark {
                if let pm = placeMark.first {
                    if pm.administrativeArea != nil || pm.locality != nil || pm.subLocality != nil {
                        guard let pC = pm.postalCode else { return }
                        guard let sL = pm.subLocality else { return }
                        self.addressString = pC + pm.administrativeArea! + pm.locality! + sL
                        // self.idokeiLabel.text =  "緯度: " + String(lat) + "経度: " + String(log)
                        let coodinate = CLLocationCoordinate2DMake(lat, log)
                        //  ピンの生成
                        let pin = MKPointAnnotation()
                        //ピンにタイトル住所表示
                        pin.title = self.addressString
                        //住所ラベルに住所を表示
                        self.textView.text = self.addressString
                        //  緯度経度を指定
                        pin.coordinate = CLLocationCoordinate2DMake(lat, log)
                        //mapViewにピンを追加
                        self.mapView.addAnnotation(pin)
                        //表示範囲設定
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        //領域設定
                        let region = MKCoordinateRegion(center: coodinate, span: span)
                        //領域をmapViewに反映
                        self.mapView.setRegion(region, animated: true)
                    }
                }
            }
        }
    }
    func showAnnotation(lat: Double,log: Double) {
        
        
        
    }
}
