//
//  ViewController.swift
//  MyMap2
//
//  Created by Kazumasa Wakamori on 2020/01/02.
//  Copyright © 2020 wakamori. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputText.delegate = self
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var displayMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        let searchKeyword = textField.text
        print(searchKeyword!) //!は強制アンラップ(ForcedUnwrapping), nilが入っていてもアンラップできてしまうので、アプリクラッシュの原因になる
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(searchKeyword!, completionHandler: { (placemarks, error) in
            
            if let placemark = placemarks?.first { // アンラップされた右辺が左辺に代入されて、{}内で使用できる
                if let location = placemark.location {
                    let targetCoordinate = location.coordinate
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = targetCoordinate
                    pin.title = searchKeyword
                    
                    self.displayMap.addAnnotation(pin)
                    self.displayMap.region = MKCoordinateRegion.init(center: targetCoordinate,
                                                                     latitudinalMeters: 500.0,
                                                                     longitudinalMeters:500.0)
                }
            } else {
                print("no result")
                let dialog = UIAlertController(title: "エラー", message: "検索結果がありません", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "了解", style: .default, handler:nil))
                self.present(dialog, animated: true, completion: nil)
            }
            
        })
        
        return true
    }
}

