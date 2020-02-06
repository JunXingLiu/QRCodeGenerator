//
//  FirstViewController.swift
//  Assignment2
//
//  Created by Jun Xing Liu on 2/6/20.
//  Copyright © 2020 Jun Xing Liu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var generate: UIButton!
    @IBOutlet weak var saveImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveImage.isEnabled = false
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button(_sender: Any){
        
        if let myString = myTextField.text{
            let data = myString.data(using: .ascii, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "InputMessage")
            
            let ciImage = filter?.outputImage
            
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let transformImage = ciImage?.transformed(by: transform)
            
            let image = UIImage(ciImage: transformImage!)
            myImageView.image = image
            
            saveImage.isEnabled = true
        }
        
    }
    
    @IBAction func buttonScreenShot(_sender: Any){
        let alert = UIAlertController(title: "Saving QR Code",
                                      message: "Do you want to proceed?",
                                      preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Yes", style: .default,
                                    handler: {action in self.screenShotMethod()})
        
        let action2 = UIAlertAction(title: "No", style: .default,
                                    handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
        
    }
    
    func screenShotMethod() {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
    }
}
