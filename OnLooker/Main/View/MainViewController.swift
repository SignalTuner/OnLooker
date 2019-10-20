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
    var sections = [" ", "Live Streams Available Now", "Previously Showcased Events"]
    var streamList:[[Stream]] = [[], [], []]
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "onlooker_background_opacity.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.videoTableView.backgroundView = imageView
        
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && sections.count == 3 {
            return 130
        } else {
            return 60
        }
    }
}

// MARK: - Tableview Delegate

extension MainViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellName = ""
        if indexPath.section == 0 && sections[indexPath.section] == " " {
            cellName = "breakingVideoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! BreakingTableViewCell
            cell.breakingNameLabel.text = streamList[indexPath.section][indexPath.row].name
            return cell
        } else {
            cellName = "subVideoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! VideoTableViewCell
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            cell.textLabel?.text = streamList[indexPath.section][indexPath.row].name
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let vw = UIView()
            let imageViewGame = UIImageView(frame: CGRect(x: tableView.frame.width/2 - 72.5, y: 8, width: 145, height: 34));
            let image = UIImage(named: "onlooker_logo.png");
            imageViewGame.image = image;
            imageViewGame.tag = section
            vw.addSubview(imageViewGame)
            return vw
        } else {
            let vw = UIView()
            let label = UILabel(frame: CGRect(x: 14, y: 0, width: tableView.frame.width, height: 34))
            label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
            label.textAlignment = .left
            label.text = sections[section]
            vw.addSubview(label)
            return vw
        }
    }
}
