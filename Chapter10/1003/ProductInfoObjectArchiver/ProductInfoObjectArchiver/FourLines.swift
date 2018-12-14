//
//  FourLines.swift
//  ProductInfoObjectArchiver
//
//  Created by CoderDream on 2018/12/14.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import Foundation

class FourLines: NSObject, NSCoding, NSCopying {
    // 预定义编码和解码时用的键
    private static let linesKey = "linesKey"
    // 定义一个字符串数组
    var lines: [String]?
    
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        lines = aDecoder.decodeObject(forKey: FourLines.linesKey) as? [String]
    }
    
    // 对lines进行编码，用linesKey键存储lines
    func encode(with aCoder: NSCoder) {
        if let saveLines = lines {
            aCoder.encode(saveLines, forKey: FourLines.linesKey)
        }
    }
    
    // 创建一个新的FourLines对象，将字符串数组复制到其中
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = FourLines()
        if let linesToCopy = lines {
            var newLines = Array<String>()
            for line in linesToCopy {
                newLines.append(line)
            }
            copy.lines = newLines
        }
        return copy
    }
}
