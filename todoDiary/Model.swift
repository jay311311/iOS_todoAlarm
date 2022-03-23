//
//  Model.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/13.
//

import Foundation


struct User:Codable{
    var email : String
    var uid : String
    var todos:[Todo]
    //
    //    var ToDictionary:[String: Any]{
    //        let autoId =  Database.database().reference().childByAutoId().key
    //        let todoArray = todos.map { todo in
    //            return todo.ToDictionary}
    //
    //        let dict:[String: Any]  = ["email":email, "uid":uid, "todos":[todoArray]]
    //        return dict
    //    }
    
    
}


struct Todo: Codable{
    var id : String
    var date : String
    var todo_title: String
    var hashtag : Array<String>
    var notification : Int
    var important : Int
    var diary_title : String
    var diary_description : String
    var diary_image: String
    
    
    var ToDictionary:[String:Any] {
        let dict: [String:Any] = ["id":id,
            "date":date,
                               "todo_title":todo_title,
                               "hashtag":hashtag,
                               "notification":notification,
                               "important":important,
                               "diary_title":diary_title,
                               "diary_description":diary_description,
                               "diary_image":diary_image]
        return dict

    }
    
    
}
