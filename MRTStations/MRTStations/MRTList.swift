//
//  MRTList.swift
//  MRTStations
//
//  Created by 刘宝的电脑 on 2017/1/2.
//  Copyright © 2017年 刘宝的电脑. All rights reserved.
//

import UIKit

class MRTList: UITableViewController {

    // MARK: Property
    var mrtMapper:[String:Array<Station>] = [:]
    var lines: Array<String> = []
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        let mrtDataManager = MRTDataManager()
        self.mrtMapper = mrtDataManager.readSoureData()
        self.lines = mrtDataManager.lines
    }

    // MARK: - Table view data source
    // 數目
    override func numberOfSections(in tableView: UITableView) -> Int {
        return lines.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arrayStation = mrtMapper[lines[section]]
        return arrayStation!.count
    }

    // 高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection sections: Int) -> CGFloat {
        return 25
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    // 內容
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return lines[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MRTCell", for: indexPath)

         //Configure the cell...
        let stations = mrtMapper[lines[indexPath.section]]
        let station = stations?[indexPath.row]
        
        // label creating
        let x_lbl = UIScreen.main.bounds.width - 100
        let lbl_Line0 = UILabel.init(frame: CGRect(x: x_lbl, y: 5, width: 65, height: 30))
        lbl_Line0.textColor = UIColor.white
        lbl_Line0.textAlignment = .center
        lbl_Line0.layer.masksToBounds = true
        lbl_Line0.layer.cornerRadius = 5
        cell.contentView.addSubview(lbl_Line0)
        
        let x_lb2 = UIScreen.main.bounds.width - 180
        let lbl_Line1 = UILabel.init(frame: CGRect(x: x_lb2, y: 5, width: 65, height: 30))
        lbl_Line1.textColor = UIColor.white
        lbl_Line1.textAlignment = .center
        lbl_Line1.layer.masksToBounds = true
        lbl_Line1.layer.cornerRadius = 5
        cell.contentView.addSubview(lbl_Line1)
        
        // content
        cell.textLabel?.text = station!.name
        
        let linesOfStations = station!.lines!
        let nameOfLines = Array(linesOfStations.keys)
        
        lbl_Line0.isHidden = true
        lbl_Line1.isHidden = true
        for line in nameOfLines {
            let indexOfLine = nameOfLines.index(of:line)
            var color: UIColor
            switch line {
                case "文湖線":
                    color = UIColor(red: 158.0/255.0, green: 101.0/255.0, blue: 46.0/255.0, alpha: 1.0)
                case "淡水信義線":
                    color = UIColor(red: 203.0/255.0, green: 44.0/255.0, blue: 48.0/255.0, alpha: 1.0)
                case "新北投支線":
                    color = UIColor(red: 248.0/255.0, green: 144.0/255.0, blue: 165.0/255.0, alpha: 1.0)
                case "松山新店線":
                    color = UIColor(red: 0.0/255.0, green: 119.0/255.0, blue: 73.0/255.0, alpha: 1.0)
                case "小碧潭支線":
                    color = UIColor(red: 206.0/255.0, green: 220.0/255.0, blue: 0.0/255.0, alpha: 1.0)
                case "中和新蘆線":
                    color = UIColor(red: 255.0/255.0, green: 163.0/255.0, blue: 0.0/255.0, alpha: 1.0)
                case "板南線":
                    color = UIColor(red: 0.0/255.0, green: 94.0/255.0, blue: 184.0/255.0, alpha: 1.0)
                case "貓空纜車":
                    color = UIColor(red: 119.0/255.0, green: 185.0/255.0, blue: 51.0/255.0, alpha: 1.0)
                default:
                    color = UIColor.black
            }
            
            if indexOfLine == 0 {
                lbl_Line0.isHidden = false
                lbl_Line0.backgroundColor = color
                lbl_Line0.text = linesOfStations[line]
            }
            else {
                lbl_Line1.isHidden = false
                lbl_Line1.backgroundColor = color
                lbl_Line1.text = linesOfStations[line]
            }
        }
        return cell
    }
    
    // MARK: - Segue Handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            guard let destination = segue.destination as? MRTDetail else {
                return
            }
            guard let cell = sender as? UITableViewCell else {
                return
            }
            guard let indexPath = self.tableView.indexPath(for:cell) else {
                return
            }
            
            let stations = mrtMapper[lines[indexPath.section]]
            let station = stations?[indexPath.row]
            destination.station = station
            
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
