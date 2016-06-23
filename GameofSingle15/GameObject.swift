//
//  GameObject.swift
//  GameofSingle15
//
//  Created by Koichi Okada on 6/7/16.
//  Copyright © 2016 GregSimons. All rights reserved.
//

import UIKit

class GameObject: NSObject {
    var rows: Int = 0       // row number of tiles
    var cols: Int = 0       // column number of tiles
    var totalTime: Int = 0  // max time for playing game
    var sounds: [String: Bool] = [String: Bool]()   // sound configurations
    // var theme: String = ""
    
    // init(rows: Int, cols: Int, totalTime: Int, theme: String) {
    init(rows: Int, cols: Int, totalTime: Int, sounds: [String: Bool]) {
        self.rows = rows
        self.cols = cols
        self.totalTime = totalTime
        self.sounds = sounds
        // self.theme = theme
    }
}
