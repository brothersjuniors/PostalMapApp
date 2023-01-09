//
//  Address.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/04.
//


import Foundation
import CoreLocation

    
    struct Address {
        var administrativeArea = "" // 都道府県 例) 東京都
        var locality = ""// 市区町村 例) 墨田区
        var subLocality = "" // 地名 例) 押上
        var thoroughfare = ""//　丁目
        var subThoroughfare = ""
    }
    
    
