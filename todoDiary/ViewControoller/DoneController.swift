//
//  DoneController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/04/27.
//

import UIKit

class DoneController: UIViewController {

    @IBOutlet weak var todoCollectionVIew: UICollectionView!
    let todoListViewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}

extension DoneController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoListViewModel.doneTodos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DoneCellController else { return UICollectionViewCell() }
        
        var todo:Todo = todoListViewModel.doneTodos[indexPath.item]
        cell.pastUI(todo:  todo)
        
        return cell
    }
  
    
}

extension DoneController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat =  collectionView.bounds.width - 30
        let height:CGFloat = 70
        return CGSize(width: width, height: height)
    }
}


class DoneCellController: UICollectionViewCell {
    @IBOutlet weak var cellBox : UIView!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var bell: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10.0
       // self.contentView.layer.zPosition = 1
    }
    
    func pastUI(todo : Todo){
        checkBox.isSelected = todo.isDone
        cellDate.text = todo.date.components(separatedBy: "T")[0]
        cellTitle.text = todo.title
        cellTitle.alpha = 0.5
        cellBox.backgroundColor = todo.isImportant ? UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0) : .white
        cellTitle.strikeThrough(from: todo.title, at: todo.title, bool: todo.isDone)
        star.isSelected =  todo.isImportant
        bell.isSelected =  todo.isNotification
        bell.tintColor =  todo.isNotification ? UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0) : .lightGray
        star.tintColor =  todo.isImportant ? .white : .lightGray
        star.isUserInteractionEnabled = false
        bell.isUserInteractionEnabled = false
       cellBox.isUserInteractionEnabled = false
    }
    
}
