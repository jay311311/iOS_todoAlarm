//
//  Model.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/13.
//

import Foundation
import simd
import UserNotifications


struct Todo: Codable,Equatable{
    var id : Int
    var date : String
    var title: String
    var isNotification : Bool
    var isImportant : Bool
    var isDone: Bool
    
    mutating func update(date:String, title:String, isNotification: Bool, isImportant: Bool, isDone:Bool ){
        self.date = date
        self.title = title
        self.isNotification = isNotification
        self.isImportant = isImportant
        self.isDone = isDone
    }
    
    static func ==(lhs:Self, rhs:Self) -> Bool {
        return lhs.id == rhs.id
    }
    
}

