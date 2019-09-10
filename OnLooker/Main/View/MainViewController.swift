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
    var toggle = true
    var sections = ["BREAKING VIDEO", "Other Videos"]
    var items = [["High Speed LA Chase"], ["Aruba", "Barber Shop in Fed Hill, MD", "OnLkr HQ"]]
    var tempSections = ""
    var tempItems:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (sections.count > 1 && section == 1) || sections.count < 2 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
            footerView.backgroundColor = .clear
            let upgradeButton = UIButton()
            upgradeButton.setTitle("Upgrade now", for: .normal)
            upgradeButton.sizeToFit()
            upgradeButton.frame = CGRect(x: footerView.bounds.size.width/2, y:footerView.bounds.size.height/2, width: footerView.bounds.size.width/3, height: footerView.bounds.size.height)
            upgradeButton.center.x = footerView.center.x
            upgradeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            upgradeButton.layer.cornerRadius = 24.0;
            upgradeButton.layer.borderWidth = 2.00
            upgradeButton.setTitleColor(.white, for: .normal)
            upgradeButton.backgroundColor = .black
            upgradeButton.tintColor = .black
            upgradeButton.layer.borderColor = UIColor.clear.cgColor
            footerView.addSubview(upgradeButton)
            return footerView
        } else {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return footerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (sections.count > 1 && section == 1) || sections.count == 1 {
            return 140
        } else {
            return 0
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        toggle = toggle ? false : true
        if toggle {
            sections.insert(tempSections, at: 0)
            items.insert(tempItems, at: 0)
        } else {
            tempSections = sections.removeFirst()
            tempItems = items.removeFirst()
        }
        videoTableView.reloadData()
        print("button action selected and this is toggle: \(toggle)")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VideoViewController {
            let vc = segue.destination as? VideoViewController
            vc?.urlSegue = "https://losangeles.cbslocal.com/live/"
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
