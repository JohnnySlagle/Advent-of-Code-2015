//
//  Day6.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/16/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

enum Instructions {
    case turn on
}

class Grid: CustomStringConvertible {
    var lights : [[Int]] = Array(count: 999, repeatedValue: Array(count: 999, repeatedValue: 0))
    
    func turn_on(top_left: (x: Int, y: Int), bottom_right: (x: Int, y: Int)) {
        for (var y = top_left.y; y <= bottom_right.y; y++) {
            for (var x = top_left.x; x <= bottom_right.x; x++) {
                lights[x][y] = 1
            }
        }
    }
    
    var description: String {
        get {
            var output = "\n"
            for row in lights {
                output = "\(row)\n"
            }
            return output
        }
    }
}

class Day6: Day {
    override func part1() -> Any {
        let instructions = input()?.componentsSeparatedByString("\n") ?? []
        for instruction in instructions {
            
        }
        
        let grid = Grid()
        print(grid)
        return "farts"
    }
}