//
//  VideoViewController.swift
//  OnLooker
//
//  Created by Jal Irani on 8/14/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    @IBOutlet weak var videoWebView: WKWebView!
    var urlSegue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let myURL = URL(string: urlSegue)
        let myRequest = URLRequest(url: myURL!)
        videoWebView.load(myRequest)
    }
}
