//
//  MRTData.swift
//  MRTStations
//
//  Created by 刘宝的电脑 on 2017/1/2.
//  Copyright © 2017年 刘宝的电脑. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataSource { // A collection of lines
    let lines: [Line]
}
struct Line { // Each lines has a collection of stations // table view sections
    let name: String // like "板南線"
    let stations:[Station]
}
struct Station { // as table view rows
    var name: String? // like "南港展覽館"
    var lines: [String : String]? // like ["板南線": "BL23", "文湖線": "BR24"]
}

extension Station: Mappable{
    init?(map: Map) {}
    mutating func mapping(map: Map){
        name <- map["name"]
        lines <- map["lines"]
    }
}

class MRTDataManager {
    var stations: [Station] = []
    var lines: [String] = []
    var dicMRTMapper:[String:Array<Station>] = [:]
    
    func readSoureData() -> Dictionary<String,Array<Station>> {
        let mrtJSONPath = Bundle.main.path(forResource: "MRT", ofType: "json")!
        let mrtJSON = try! String(contentsOfFile: mrtJSONPath)
        stations = Mapper<Station>().mapArray(JSONString:mrtJSON)!
        
        for mrtStation in stations {
            let lineSet = Array(mrtStation.lines!.keys)[0]
            if !(lines.contains(lineSet)) {
                lines.append(lineSet) // create a array to put station by line name
            }
        }
        
        for line in lines {
            dicMRTMapper[line] = []
            for station in stations {
                let lineNames = Array(station.lines!.keys)
                if lineNames.contains(line) {
                    dicMRTMapper[line]?.append(station)
                }
            }
        }
        return dicMRTMapper
    }
}
