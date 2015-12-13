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
        print("Override me")
        return 0
    }

    func part2() -> Any {
        print("Override me")
        return 0
    }
    
    func input() -> String? {
        return try? String(contentsOfFile: "/Users/Johnny/Desktop/AdventOfCode/AdventOfCode/\(self.dynamicType)-Input")
    }
}