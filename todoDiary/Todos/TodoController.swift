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
    var todos :[Todo] = []
    
    @IBOutlet weak var todoCollectionVIew: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
    }
    
    func fetchData(){
        db.child("user").child("\(userUid!)").child("todos").observeSingleEvent(of: .value) { snapshot in
//            do{
//                self.todos.removeAll()
//                let decoder =  JSONDecoder()
//
//                let data = try JSONSerialization.data(withJSONObject:snapshot.value , options: [])
//                print("\(data)")
//                let todo:[Todo] = try decoder.decode([Todo].self, from: data)
//                print("\(todo)")
//
//                self.todos = todo
//
//            } catch let error {
//                print("여기? 거짓")
//
//                print("error: ", error.localizedDescription)
//            }
        }
//        self.todoCollectionVIew.reloadData()
    }
   

    
    @IBAction func openModal(_ sender: UIButton) {
        performSegue(withIdentifier: "addTodo", sender: nil)
    }
}


extension TodoController : UICollectionViewDataSource,  UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("갯수를 보여줘 \(todos.count)")
        return todos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        print("모습을 보여줘")

        cell.layer.cornerRadius = 10.0
                cell.layer.borderWidth = 0.0
                cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
                cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.2
                cell.layer.masksToBounds = false //<-
                return cell
    }
    
    
}

extension TodoController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width:CGFloat =  collectionView.bounds.width - 30
        let height:CGFloat = 70
        
        return CGSize(width: width, height: height)
    }
    

}
