//
//  Day5.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

class Day5: Day {
    
    override func part1() -> Any {
        let words = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        return words.filter { word -> Bool in
            // Check naughty words
            
            // (ab|cd|pq|xy) – matches any one of those double letter combos
            guard word.matches("(ab|cd|pq|xy){1,}") == 0 else {
                return false
            }
            
            // At least 3 vowels
            // [aeiou] – matches any of these letters
            guard word.matches("[aeiou]") >= 3 else {
                return false
            }
            
            // At least a double letter
            // ([a-z]) – matches any letter and the ()s make it a group
            // \\1 – match the result of the first group, again
            guard word.matches("([a-z])\\1") >= 1 else {
                return false
            }
            
            return true
        }.count
    }
    
    override func part2() -> Any {
        let words = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        return words.filter { word -> Bool in
            
            // pair of any two letters that appears at least twice in the string without overlapping
            // Note: RegEx breakdown (for future Johnny)
            // ([a-z]{2})[a-z]*\\1
            // ([a-z]{2}) is the first group and it matches any two {2} letters between a-z [a-z]
            // [a-z]* matches zero or more letters between a-z
            // \\1 should just be \1 but I have to escape the \. It matches the match of group 1 ([a-z]{2}) again
            guard word.matches("([a-z]{2})[a-z]*\\1") >= 1 else {
                return false
            }
            
            // At least one letter which repeats with exactly one letter between them
            // ([a-z]{1}) – matches one letter
            // [a-z]{1} – matches one letter
            // \\1 – matches the first matched letter, again
            guard word.matches("([a-z]{1})[a-z]{1}\\1") >= 1 else {
                return false
            }
            
            return true
        }.count
    }
}

extension String {
    func matches(pattern: String) -> Int {
        if let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions()) {
            return regex.matchesInString(self, options: .ReportCompletion, range: NSMakeRange(0, self.characters.count)).count
        }
        return 0
    }
}