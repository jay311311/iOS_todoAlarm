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

class TodoManager {
    // - 싱글톤 구현
    static let shared =  TodoManager()
    
    // - 아이디 생성
    static var lastId: Int  = 0
    
//    // - notificationTime
//    var notificationTime:String = "00:00:00"
//    
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
        if let index = todos.firstIndex(of: todo){ todos.remove(at: index)}
        saveTodo()
    }

    func addTodo(_ todo :Todo){
        todos.append(todo)
        saveTodo()
    }
    func saveTodo(){
        // 데이터를 json 파일로 저장하러 가기
        Storage.store(todos, to: .documents, as: "todo.json")
    }
    func setKoreanDate(date : Date) -> String{
      
        let dateFomatter = DateFormatter()
        dateFomatter.timeZone = NSTimeZone(name:"ko_KR") as TimeZone?
        dateFomatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let today = dateFomatter.string(from: date)
        return today
    }
    
    func setNotificationTime(_ todo : Todo, date:String, identifier:Int, isNotification:Bool){
        let uuidString  =  String(identifier)
        
        if isNotification {
            // 2. create the notification content

        let content =  UNMutableNotificationContent()
        content.title = "hey i'm notification"
        content.body  =  "\(todo.title)"
        
        //3. create the notification trigger
        print("들어온 값 :\(date)")
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let isKoreanTime =  dateFomatter.date(from:date)!
        print("변경된 값\(isKoreanTime)")
        let dateComponents =  Calendar.current.dateComponents([.year, .month, .day, .hour,.minute, .second], from: isKoreanTime)
        print("잘 갖춰진 값\(dateComponents)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //4. create the request
        
        let request =  UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //5. register the request
       
        let ceneter = UNUserNotificationCenter.current()
        ceneter.add(request) { error in
            print("왜때문데?? \(String(describing: error?.localizedDescription))")
        }
        } else{
            print("헤제를 눌렀다")
            let center = UNUserNotificationCenter.current()
            center.removeDeliveredNotifications(withIdentifiers: [uuidString])
            center.removePendingNotificationRequests(withIdentifiers: [uuidString])
            
        }
    }
    
   
    
    func retrieveTodo() {
        todos = Storage.retrive("todo.json", from: .documents, as: [Todo].self) ?? []
       // todos = sortedTodo(todos: todos)
        //print(test)
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}

class TodoViewModel{
    
    private let manager =  TodoManager.shared
    
    var todos:[Todo] { return manager.todos }
    
    var soonTodos:[Todo]{
      //  var filterdTodos:[Date] = []
        let nowDate = Date()
        var result:[Todo]  = []
        for (index,todo) in todos.enumerated(){
            let datefommat =  DateFormatter()
            datefommat.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
            let realDate = datefommat.date(from : todo.date)!
            if realDate >= nowDate {
                result.append(todo)
            }
        }
        result = sortedTodo(todos: result)
        return result
    }
    
    var doneTodos:[Todo]{
        let nowDate = Date()
        let koreanDate = manager.setKoreanDate(date: nowDate)
        var result:[Todo]  = []
        for (index,todo) in todos.enumerated(){
            let datefommat =  DateFormatter()
            datefommat.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
            let realDate = datefommat.date(from : todo.date)!
            let nowDate = datefommat.date(from : koreanDate)!
            if realDate < nowDate {
                result.append(todo)
            }
        }
        result = sortedTodo(todos: result)
        return result
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
    func setKoreanDate(date :Date) -> String{
        return manager.setKoreanDate(date:date )
    }
    func setNotificationTime(_ todo: Todo, date : String, identifier :Int, isNotification:Bool){
        return manager.setNotificationTime(todo, date: date, identifier : identifier, isNotification: isNotification )
    }
    
    func sortedTodo(todos :[Todo]) ->[Todo] {
        // 정렬
        let dateFormater =  DateFormatter()
        dateFormater.dateFormat =  "yyyy-MM-dd HH:mm:ss +0000"
        let todoSorted =  todos.sorted{(first, second) -> Bool in
//            if first.isImportant != second.isImportant {
//                return first.isImportant
//            }
      let firstDate:Date = dateFormater.date(from: first.date)!
      let secondDate:Date = dateFormater.date(from: second.date)!
        return firstDate < secondDate
        }
       return todoSorted
    }
    
  //  var notificationTime: String { return manager.notificationTime }
}


