//
//  MainViewController.swift
//  OnLooker
//
//  Created by Jal Irani on 8/8/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var videoTableView: UITableView!
    var sections = ["BREAKING VIDEO", "Other Videos"]
    var tempSections = ""
    var tempItems:[String] = []
    var streamList:[[Stream]] = [[],[]]
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "streams")
        
        ref.observe(.value, with: { snapshot in
            var newItems:[[Stream]] = [[],[]]
            for child in snapshot.children {
                if let dataSnap = child as? DataSnapshot {
                    if let item = Stream(snapshot: dataSnap) {
                        if item.type == "important" && item.active {
                            newItems[0].append(item)
                        } else if item.active {
                            newItems[1].append(item)
                        }
                    }
                }
            }
            self.streamList = newItems
            
            // Allows sections to be removed
            if self.streamList[0].count == 0 && self.sections.count > 1 {
                self.sections.removeFirst()
                self.streamList.removeFirst()
            } else if self.sections.count == 1 && self.streamList.count == 2 {
                self.sections.insert("BREAKING NEWS", at: 0)
            }
            
            
            self.videoTableView.reloadData()
        })
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        return formattedDate
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VideoViewController {
            
            let vc = segue.destination as? VideoViewController
            let streamIndex = videoTableView.indexPathForSelectedRow?.row
            let streamSection = videoTableView.indexPathForSelectedRow?.section
            streamList[streamSection!][streamIndex!].ref?.updateChildValues([
                "lastViewed": getCurrentDate()
            ])
            print(streamList[streamSection!][streamIndex!].url)
            vc?.urlSegue = streamList[streamSection!][streamIndex!].url
        }
    }
}

// MARK: - Tableview Datasource

extension MainViewController {
    
    // Bug here
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamList[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

// MARK: - Tableview Delegate

extension MainViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subVideoCell", for: indexPath)
        cell.textLabel?.text = streamList[indexPath.section][indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}
