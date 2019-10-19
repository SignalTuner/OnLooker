//
//  MainViewController.swift
//  OnLooker
//
//  Created by Jal Irani on 8/8/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import UIKit
import Firebase

// Problem, deque is called before the section is removed, so changing is incorrect

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var videoTableView: UITableView!
    var sections = [" ", "Live Streams Available Now", "Previously Showcased Events"]
    var streamList:[[Stream]] = [[], [], []]
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "streams")
        
        ref.observe(.value, with: { snapshot in
            var newItems:[[Stream]] = [[], [], []]
            for child in snapshot.children {
                if let dataSnap = child as? DataSnapshot {
                    if let item = Stream(snapshot: dataSnap) {
                        if item.type == "important" && item.active {
                            newItems[0].append(item)
                        } else if item.type == "archived" && item.active {
                            newItems[2].append(item)
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
            } else if self.sections.count == 2 && self.streamList.count == 3 {
                self.sections.insert(" ", at: 0)
            }
            
            
            self.videoTableView.reloadData()
        })
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        print("willDisplayHeaderView called for section: \(section)")
        if let header = view as? UITableViewHeaderFooterView {
            if section == 0 && sections[section] == " " {
                print("Image is displayed for: \(section)")
                // Make text smaller to move image down
                let imageViewGame = UIImageView(frame: CGRect(x: tableView.frame.width/3, y: 0, width: 145, height: 34));
                let image = UIImage(named: "onlooker_logo.png");
                imageViewGame.image = image;
                header.contentView.addSubview(imageViewGame)
            } else {
                header.textLabel?.textColor = .black
                header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && sections.count == 3 {
            return 130
        } else {
            return 60
        }
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
        var cellName = ""
        if indexPath.section == 0 && sections[indexPath.section] == " " {
            print("Deque called: \(sections[0])")
            cellName = "breakingVideoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! BreakingTableViewCell
            cell.breakingNameLabel.text = streamList[indexPath.section][indexPath.row].name
            return cell
        } else {
            cellName = "subVideoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! VideoTableViewCell
            cell.textLabel?.text = streamList[indexPath.section][indexPath.row].name
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}
