//
//  ViewController.swift
//  SunriseApp
//
//  Created by Kazumasa Wakamori on 2020/01/04.
//  Copyright © 2020 wakamori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameInput: UITextField!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func findSunrise(_ sender: Any) {
        // openweathermap.orgのAPIを使用
        let appid = ""
        let url =  "http://api.openweathermap.org/data/2.5/forecast?q=\( cityNameInput.text!)&APPID=\(appid)"
        getUrl(url: url)
        
    }
        
    func getUrl(url: String) {
        do {
            // HTTPリクエストを実行してJSONを取得
            let apiUrl = URL(string: url)!
            let data = try Data(contentsOf: apiUrl)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            // JSONをパースして日の出時刻(unixtime)を取得し、Date型に変換
            let city = json["city"] as! [String:Any]
            let sunrise = city["sunrise"]
            let sunriseDate = NSDate(timeIntervalSince1970: sunrise as! TimeInterval)
            
            // 日の出時刻(Date型)を文字列に変換
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let sunriseDateStr: String = formatter.string(from: sunriseDate as Date)
            
            // ラベルに日の出時刻を表示
            self.sunriseTimeLabel.text = "日の出時刻：\(sunriseDateStr)"
        } catch {
            self.sunriseTimeLabel.text = "サーバに接続できません"
        }
    }
}

