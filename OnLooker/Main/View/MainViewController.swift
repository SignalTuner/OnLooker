//
//  MainViewController.swift
//  OnLooker
//
//  Created by Jal Irani on 8/8/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var videoTableView: UITableView!
    var arr = [1,2,3,4,5,6]
    let sections = ["pizza", "deep dish pizza", "calzone"]
    let items = [["Margarita", "BBQ Chicken"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns", "mushrooms"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VideoViewController {
            let vc = segue.destination as? VideoViewController
            vc?.urlSegue = "http://www.apple.com"
        }
    }
}

// MARK: - Tableview Datasource

extension MainViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

// MARK: - Tableview Delegate

extension MainViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subVideoCell", for: indexPath) 
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}
