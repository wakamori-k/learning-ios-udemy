//
//  ViewController.swift
//  MyCamera
//
//  Created by Kazumasa Wakamori on 2020/01/03.
//  Copyright © 2020 wakamori. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var photoImage: UIImageView!
    
    @IBAction func cameraLaunchAction(_ sender: Any) {
        // カメラへのアクセスチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラの利用が許可されている場合
            print("camera can be used")
            
            // カメラから画像を取得する
            let ipc = UIImagePickerController()
            ipc.sourceType = .camera
            ipc.delegate = self
            present(ipc, animated: true, completion: nil) // カメラを開く
        } else {
            // カメラの利用が許可されていない場合
            print("camera is not available")
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        if let sharedImage = photoImage.image {
            let shredItems = [sharedImage]
            let controller = UIActivityViewController(activityItems: shredItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view // ipadにも対応させる
            present(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // UIImagePickerControllerのdelegateメソッド
     
        // 撮影した画像をUIImageに表示する
        photoImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // カメラを閉じる
        dismiss(animated: true, completion: nil)
    }
    
}

