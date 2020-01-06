//
//  ShareViewController.swift
//  OnLooker
//
//  Created by Jal Irani on 12/17/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift

class ShareViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var streamTextField: UITextField!
    var ref: DatabaseReference!
    var submittedData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submittedData = false
        self.streamTextField.delegate = self
        self.streamTextField.becomeFirstResponder()
        streamTextField.layer.backgroundColor = UIColor.clear.cgColor
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
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let streamText = textField.text, !streamText.isEmpty else { return false }
        
        ref = Database.database().reference(withPath: "submit")
        
//        ref.observe(.value, with: { snapshot in
//            for child in snapshot.children {
//                if let dataSnap = child as? DataSnapshot {
//                    if let streamList = dataSnap.value as? String {
//                        print(streamList)
//                        print(streamText)
//                        print(snapshot.childrenCount)
//                    }
//                }
//            }
//        })
        
        guard let key = self.ref.childByAutoId().key else { return false }
        let link = ["\(String(describing: key))": streamText]
        self.ref.child(key).setValue(link)
        self.submittedData = true
        print("textFieldShouldReturn Called")
        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }


}
