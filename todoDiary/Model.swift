//
//  Model.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/13.
//

import Foundation

struct User{
    var email : String
    var userId : String
    var  userUuid : String
    var todos:[Todo]
    
    var ToDictionary:[String: Any]{
        var todoArray = todos.map { todo in
           return todo.ToDictionary
        }
        let dict:[String: Any]  = ["email":email, "userId":userId, "userUuid":userUuid, "todos":todoArray]
        return dict
    }
}


struct Todo{
    var date : String
    var todo_title: String
    var hashTag : String
    var notification : Int
    var important : Int
    var diary_Title : String
    var diary_description : String
    var dairy_Image: String
    
    var ToDictionary:[String:Any] {
        let dict: [String:Any] = ["date":date,
                               "todo_title":todo_title,
                               "hashTag":hashTag,
                               "notification":notification,
                               "important":important,
                               "diary_Title":diary_Title,
                               "diary_description":diary_description,
                               "dairy_Image":dairy_Image]
        return dict
        
    }
}
