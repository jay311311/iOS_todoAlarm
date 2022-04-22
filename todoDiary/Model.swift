//
//  Model.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/13.
//

import Foundation
import simd

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

class TodoManager {
    // - 싱글톤 구현
    static let shared =  TodoManager()
    
    // - 아이디 생성
    static var lastId: Int  = 0
    
    // - 데이터를 넣을 공간 생성
    var todos:[Todo] = []
    
    func createTodo(title : String, date : String ) -> Todo {
        let nextId: Int  = TodoManager.lastId + 1
        TodoManager.lastId  = nextId
        return Todo(id: nextId, date: date, title: title, isNotification: false, isImportant: false, isDone: false)
    }
    
    func updateTodo(_ todo :Todo){
        // 데이터 업데이트
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].update(date: todo.date, title: todo.title, isNotification: todo.isNotification, isImportant: todo.isImportant, isDone: todo.isDone)
        saveTodo()
    }
    
    func deleteTodo(_ todo:Todo){
        //데이터 삭제
        if let index = todos.firstIndex(of: todo){
            todos.remove(at: index)
        }
        saveTodo()
    }
    
    func addTodo(_ todo :Todo){
        todos.append(todo)
        saveTodo()
    }
    func saveTodo(){
        // 데이터를 json 파일로 저장하러 가기
        todos = sortedTodo(todos: todos)
        Storage.store(todos, to: .documents, as: "todo.json")
    }
    
    func sortedTodo(todos :[Todo]) ->[Todo] {
        // 정렬하는 알고리즘 조사
            let dateFormater =  DateFormatter()
        
            dateFormater.dateFormat =  "yyyy-mm-dd"
        //guard let test = dateFormater.dateFormat else { return  }
        
      let todoSorted =  todos.sorted{(first, second) -> Bool in
            if first.isImportant != second.isImportant {
                return first.isImportant
            }
            var firstDate:Date = dateFormater.date(from: first.date)!
            var secondDate:Date = dateFormater.date(from: second.date)!
            return firstDate < secondDate
        }
        return todoSorted
    }
    func retrieveTodo() {
        todos = Storage.retrive("todo.json", from: .documents, as: [Todo].self) ?? []
        
        //print(test)
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}

class TodoViewModel{
    // enum 생략
//    enum Section: Int, CaseIterable {
//        case today
//        case upcoming
//
//        var title: String {
//            switch self {
//            case .today: return "Today"
//            default: return "Upcoming"
//            }
//        }
//    }
//
    // enum 생략
    
    
    private let manager =  TodoManager.shared
    
    var todos:[Todo] {
        return manager.todos
    }
    
//    var todayTodos:[Todo]{
//        return manager.todos.filter { $0.date == Date()}
//    }
    
    var numOfSection:Int{
        return manager.todos.count
    }
    
    func addTodo(_ todo:Todo){
        return manager.addTodo(todo)
    }
    func deleteTodo(_ todo:Todo){
        return manager.deleteTodo(todo)
    }
    func updateTodo(_ todo:Todo){
        return manager.updateTodo(todo)
    }
    func loadTask(){
        manager.retrieveTodo()
    }
    
    
}


