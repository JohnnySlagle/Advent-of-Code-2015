//
//  Day.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

class Day {    
    func part1() -> Any {
        return "Override me"
    }

    func part2() -> Any {
        return "Override me"
    }
    
    func input() -> String? {
        return try? String(contentsOfFile: "/Users/Johnny/Desktop/AdventOfCode/AdventOfCode/Inputs/\(self.dynamicType)-Input")
    }
}