//
//  TodoController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/06.
//

import UIKit
import Firebase
import FirebaseDatabase

class TodoController: UIViewController {
    var i  = 0
    let db =  Database.database().reference().child("user")
    let userUid =  Auth.auth().currentUser?.uid
    var todos = [Todo]()
    var textTitle = ""
    
    @IBOutlet weak var todoCollectionVIew: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
 
    func fetchData(){
        todos.removeAll()
       db.child("\(userUid!)").child("todos").observe(.childAdded) { (snapshot) in
            do{
              //  let key =  snapshot.key
                guard let myTodos =  snapshot.value as? [String : Any] else {return}
               // print("이것은 키이이이 ---> \(key) // 이것은 값-----> \(myTodos)")
                let decoder =  JSONDecoder()
                let data =  try JSONSerialization.data(withJSONObject: myTodos, options: [])
                let todo = try decoder.decode(Todo.self, from: data)
                self.todos.append(todo)
                DispatchQueue.main.async {
                    self.todoCollectionVIew.reloadData()
                }
            }catch let error{
                print(String(describing: error))            }
        }
    }
    
    @IBAction func openModal(_ sender: UIButton) {
        performSegue(withIdentifier: "addTodo", sender: nil)
    }
    
    func dataUpdate(id: String?, element:Int?, category:String? ) {
        guard let id = id, let element = element, let category = category else { return }

        db.child("\(userUid!)").child("todos").child(id).child(category).setValue(element)
    }
}


extension TodoController : UICollectionViewDataSource,  UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TodoCellController
        let todoData =  todos[indexPath.row]
        // - 데이터 fetch
        cell.cellTitle.text = todoData.todo_title
        // - hasgtag(UILabel) 동적생성
        todoData.hashtag.map { hash in
            let hashLabel =  paddingLabel()
            hashLabel.translatesAutoresizingMaskIntoConstraints = false
            hashLabel.isUserInteractionEnabled = true
            hashLabel.font = UIFont.systemFont(ofSize: 12)
            hashLabel.textColor = .lightGray
            hashLabel.text =  "# \(hash)"
            cell.hashLabelBox.addArrangedSubview(hashLabel)
        }
        // 별표 표시
        if todoData.important == 1{
            cell.star.isSelected = true
          //  cell.star.setImage(UIImage(systemName:"star.fill"), for: .normal)
            cell.star.tintColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0)
        }else{
            cell.star.isSelected = false
           // cell.star.setImage(UIImage(systemName:"star"), for: .normal)
            cell.star.tintColor = .lightGray
        }
        //종 표시
        if todoData.notification == 1{
            cell.bell.isSelected = true
            cell.bell.tintColor = UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0)
        }else{
            cell.bell.isSelected = true

            cell.bell.tintColor = .lightGray
        }
        // 체크박스 표시
        if todoData.todo_done == 1 {
            cell.checkBox.isSelected = true
            cell.bell.isEnabled = false
            cell.star.isEnabled = false
           
           // cell.cellTitle.isEnabled = false
            cell.cellTitle.strikeThrough(from: todoData.todo_title, at: todoData.todo_title, bool: cell.checkBox.isSelected)
            cell.cellTitle.textColor = UIColor(white: 80/100, alpha: 1.0)
            cell.checkBox.setImage(UIImage(systemName: "checkmark",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)), for: .normal)
            cell.checkBox.tintColor = UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0)
        }else{
            cell.checkBox.isSelected = false
            cell.bell.isEnabled = true
            cell.star.isEnabled = true
            cell.cellTitle.strikeThrough(from: todoData.todo_title, at: todoData.todo_title, bool: cell.checkBox.isSelected)
            cell.cellTitle.textColor = UIColor(red: 10/225, green: 27/225, blue: 57/225, alpha: 1.0)
            cell.checkBox.setImage(UIImage(systemName: "square"), for: .normal)
            cell.checkBox.tintColor = .lightGray
        }
        
       // accessId 넘겨주기 for update
        cell.accessibilityIdentifier =  todoData.id
        cell.checkBox.accessibilityIdentifier = todoData.id
        cell.bell.accessibilityIdentifier = todoData.id
        cell.star.accessibilityIdentifier =  todoData.id
 
        //cell 레아이웃
        cell.layer.cornerRadius = 10.0
        cell.layer.borderWidth = 0.0
        //cell.layer.shadowColor = UIColor.lightGray.cgColor
       // cell.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
       // cell.layer.shadowRadius = 5.0
       // cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        return cell
    }
}

extension TodoController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width:CGFloat =  collectionView.bounds.width - 30
        let height:CGFloat = 75
        
        return CGSize(width: width, height: height)
    }
    
    
}




