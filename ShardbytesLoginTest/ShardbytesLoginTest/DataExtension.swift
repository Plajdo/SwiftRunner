//
//  DataExtension.swift
//  ShardbytesLoginTest
//
//  Created by Filip Šašala on 26/07/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import Foundation

extension Data{
    
    func toString() -> String{
        return String(data: self, encoding: .utf8)!
    }
    
}
