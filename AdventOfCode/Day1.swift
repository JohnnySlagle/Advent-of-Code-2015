//
//  Day1.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

class Day1: Day {
    
    func notLisp(path: String, findPosition: Bool = false) -> (floor: Int, position: Int) {
        var position = 1
        var floor = 0
        
        for c in path.characters {
            switch c {
            case "(":
                floor++
            case ")":
                floor--
            default:
                break
            }
            
            if (findPosition) {
                if (floor == -1) {
                    break
                }
                position++
            }
        }
        return (floor, position)
    }
    
    func part1() -> Any {
        return notLisp(input()!).floor
    }
    
    func part2() -> Any {
        return notLisp(input()!, findPosition: true).position
    }
    
    // NOte: Maybe make this into a generated method based on class name where it jsut assumes the input method is Day#-Input
    func input() -> String? {
        return try? String(contentsOfFile: "/Users/Johnny/Desktop/AdventOfCode/AdventOfCode/Day1-Input")
    }
}