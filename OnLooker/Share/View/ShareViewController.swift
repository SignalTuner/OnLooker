//
//  ShareViewController.swift
//  OnLooker
//
//  Created by Jal Irani on 12/17/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import UIKit
import Firebase

class ShareViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var streamTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.streamTextField.delegate = self
        self.streamTextField.becomeFirstResponder()
        streamTextField.layer.backgroundColor = UIColor.white.cgColor
        streamTextField.layer.masksToBounds = false
        streamTextField.layer.shadowColor = UIColor(displayP3Red: 0/255.0, green: 106/255.0, blue: 181/255.0, alpha: 1.0).cgColor
        streamTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        streamTextField.layer.shadowOpacity = 1.0
        streamTextField.layer.shadowRadius = 0.0
        
        let background = UIImage(named: "onlooker_background_opacity.png")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let streamText = textField.text else { return false }
        print(streamText)
        self.dismiss(animated: true, completion: nil)
        return true
    }


}
