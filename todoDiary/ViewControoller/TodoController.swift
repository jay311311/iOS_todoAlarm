//
//  TodoController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/06.
//

import UIKit
//import Firebase
//import FirebaseDatabase

class TodoController: UIViewController {
//    var i  = 0

    
    @IBOutlet weak var todoCollectionVIew: UICollectionView!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    @IBOutlet weak var inputTextField : UITextField!
    @IBOutlet weak var calendarBtn :UIButton!
    @IBOutlet weak var addBtn :UIButton!
    let todoListViewModel = TodoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //키보드 디텍션 : 키보드 높이가 올라오면 인풋창도 같이 올라와서 노출되게끔
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        todoListViewModel.loadTask()
       


    }
    @IBAction func tapCalendarButton(_ sender: Any) {
        calendarBtn.isSelected = !calendarBtn.isSelected
    }
    
    @IBAction func tapAddTaskButton(_ sender: Any) {
        addBtn.isSelected = !addBtn.isSelected
        
    }
    @IBAction func tapBG(_ sender: Any) {
        inputTextField.resignFirstResponder()
    }
    

//    @IBAction func openModal(_ sender: UIButton) {
//        performSegue(withIdentifier: "addTodo", sender: nil)
//    }
    

}

extension TodoController{
    @objc private func adjustInputView (noti : Notification){
        guard let userInfo = noti.userInfo else  { return }
        guard let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name ==  UIResponder.keyboardWillShowNotification{
            let adjustmentHeight = keyboardFrame.height -  view.safeAreaInsets.bottom
            inputViewBottom.constant =  adjustmentHeight
        }else {
            inputViewBottom.constant =  0
        }
        print("keyboardFram --->\(keyboardFrame)")
    }
    // 키보드에  높이에 따른 인풋뷰 위치 변경
}

extension TodoController : UICollectionViewDataSource,  UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoListViewModel.numOfSection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TodoCellController else {
            return UICollectionViewCell()
        }
       // cell.cellTitle.text = todoData.todo_title
        var todo : Todo
        todo = todoListViewModel.todos[indexPath.item]
       // todo = todoListViewModel.laterTodos[indexPath.item]
        cell.updateUI(todo: todo)
        // - hasgtag(UILabel) 동적생성
//        todoData.hashtag.map { hash in
//            let hashLabel =  paddingLabel()
//            hashLabel.translatesAutoresizingMaskIntoConstraints = false
//            hashLabel.isUserInteractionEnabled = true
//            hashLabel.font = UIFont.systemFont(ofSize: 12)
//            hashLabel.textColor = .lightGray
//            if hash == "" {
//                hashLabel.text =  ""
//            }else {
//                hashLabel.text =  "# \(hash)"
//            }
//            cell.hashLabelBox.addArrangedSubview(hashLabel)
//        }
        // 별표 표시
//        if todoData.important == 1{
//            cell.star.isSelected = true
//            cell.star.tintColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0)
//        }else{
//            cell.star.isSelected = false
//            cell.star.tintColor = .lightGray
//        }
        //종 표시
//        if todoData.notification == 1{
//            cell.bell.isSelected = true
//            cell.bell.tintColor = UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0)
//        }else{
//            cell.bell.isSelected = true
//            cell.bell.tintColor = .lightGray
//        }
        // 체크박스 표시
//        if todoData.todo_done == 1 {
//            cell.checkBox.isSelected = true
//            cell.bell.isEnabled = false
//            cell.star.isEnabled = false
//           // cell.cellTitle.isEnabled = false
//            cell.cellTitle.strikeThrough(from: todoData.todo_title, at: todoData.todo_title, bool: cell.checkBox.isSelected)
//            cell.cellTitle.textColor = UIColor(white: 80/100, alpha: 1.0)
//            cell.checkBox.setImage(UIImage(systemName: "checkmark",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)), for: .normal)
//            cell.checkBox.tintColor = UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0)
//        }else{
//            cell.checkBox.isSelected = false
//            cell.bell.isEnabled = true
//            cell.star.isEnabled = true
//            cell.cellTitle.strikeThrough(from: todoData.todo_title, at: todoData.todo_title, bool: cell.checkBox.isSelected)
//            cell.cellTitle.textColor = UIColor(red: 10/225, green: 27/225, blue: 57/225, alpha: 1.0)
//            cell.checkBox.setImage(UIImage(systemName: "square"), for: .normal)
//            cell.checkBox.tintColor = .lightGray
//        }
        
       // accessId 넘겨주기 for update
//        cell.accessibilityIdentifier =  todoData.id
//        cell.checkBox.accessibilityIdentifier = todoData.id
//        cell.bell.accessibilityIdentifier = todoData.id
//        cell.star.accessibilityIdentifier =  todoData.id
//        cell.deleteBtn.accessibilityIdentifier =  todoData.id
//        cell.tag = indexPath.row
//
        //cell 레아이웃
        cell.layer.cornerRadius = 10.0
        cell.layer.borderWidth = 0.0
        cell.layer.masksToBounds = false
        
        //cell swipe button
//        cell.deleteBtn.addTarget(self, action: #selector(deleteTodo), for: .touchUpInside)
//        cell.updateBtn.addTarget(self, action: #selector(updateTodo), for: .touchUpInside)
        return cell
    }
    
//    @objc func deleteTodo(_ sender : UIButton){
//        guard let accecsskey = sender.accessibilityIdentifier,
//            let cellboxWidth = sender.superview?.superview?.bounds.width,
//            let cellBoxHeight = sender.superview?.bounds.height else { return }
//   //     print("\(todoCollectionVIew.subviews)")
//        dataDelete(id: accecsskey, tag:sender.tag)
//        print("\(accecsskey) &\(sender.tag)")
////        UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseOut, animations: {
////            sender.superview?.superview?.superview?.frame = CGRect(x: 0, y: 0.0, width: cellboxWidth, height: cellBoxHeight)
////        }, completion: nil)
//        print("click delete btn+ \(accecsskey)")
//    }
//
//    @objc func updateTodo(){
//        print("click update btn")
//    }
}

extension TodoController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat =  collectionView.bounds.width - 30
        let height:CGFloat = 75
        return CGSize(width: width, height: height)
    }
}



class TodoCellController: UICollectionViewCell  {
    
    
    @IBOutlet weak var swipeBox: UIStackView!
    @IBOutlet weak var cellBox : UIView!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var bell: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
   
   
   
  
   // view객체의 메소드가 다른 비지니스 로직에까지 영향을 주지 않기위해 클로저 사용
    var doneBellTapHandler : ((Bool)->Void)?
    var donStarTapHandler : ((Bool)->Void)?
    var doneCheckBoxTapHandler : ((Bool)->Void)?
    var doneDeleteButtonTapHandler : (()->Void)?
    
    override func awakeFromNib() {
      
        super.awakeFromNib()
        configSwipeBtn()
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.zPosition = 1
        reset()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    func updateUI(todo : Todo){
        // 셀 업데이트 하기
        checkBox.isSelected = todo.isDone
        cellDate.text = todo.date
        cellTitle.text = todo.title
        cellTitle.alpha = todo.isDone ? 0.2 : 1
        cellTitle.strikeThrough(from: todo.title, at: todo.title, bool: todo.isDone)
      //  deleteBtn.isHidden =  todo.isDone == false
        star.isSelected =  todo.isImportant
        bell.isSelected =  todo.isNotification
        star.tintColor =  todo.isImportant ? UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0) : .lightGray
        bell.tintColor =  todo.isNotification ? UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0) : .lightGray
    }
    
    func reset(){
        cellTitle.alpha = 1
        
    }
    
    func configSwipeBtn(){
        // - 제스처
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipBtn(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipBtn(_:)))
        leftSwipe.direction =  UISwipeGestureRecognizer.Direction.left
        rightSwipe.direction =  UISwipeGestureRecognizer.Direction.right
        cellBox.addGestureRecognizer(leftSwipe)
        cellBox.addGestureRecognizer(rightSwipe)
    }
    
    @objc func swipBtn(_ sender : UISwipeGestureRecognizer){
        
        if let swipeGesture = sender as? UISwipeGestureRecognizer{
            let width =  cellBox.bounds.size.width
            let height = cellBox.bounds.size.height
            let swipeBoxWidth = swipeBox.bounds.size.width
        //    print("width:\(width),  height: \(height), swipeBoxWidth:\(swipeBoxWidth) ")
            switch swipeGesture.direction{
            case .left :
                print("스와이프 블럭1,\(self.accessibilityIdentifier) & ,\(self.tag)")
              
                UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseOut, animations: {
                    self.cellBox.frame = CGRect(x: -swipeBoxWidth, y: 0.0, width: width, height: height)
                }, completion: nil)
              //  TodoController().dataDelete(id: self.accessibilityIdentifier!, tag:self.tag)
            case .right:
                print("스와이프 블럭2,\(self.cellBox.frame)")
                UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseOut, animations: {
                    self.cellBox.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
                }, completion: nil)

            default:break
            }
        }else{
           print("test")
        }


    }
  
    
    @IBAction func touchStar(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            star.tintColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0)
          //  TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 1, category: "important")
        }else{
           star.tintColor = .lightGray
          //  TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 0, category: "important")
        }
    }
    
    @IBAction func touchBell(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            bell.tintColor = UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0)
        //    TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 1, category: "notification")
        }else{
           bell.tintColor = .lightGray
         //   TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 0, category: "notification")
        }
    }
    

    @IBAction func didTodo(_ sender: UIButton) {
        checkBox.isSelected = !checkBox.isSelected
        let isDone = checkBox.isSelected
        bell.isEnabled = !isDone
        star.isEnabled = !isDone
        cellTitle.alpha = isDone  ? 0.2 : 1
        cellDate.alpha = isDone  ? 0.2 : 1
        cellTitle.strikeThrough(from: cellTitle.text, at: cellTitle.text, bool: isDone)
        doneCheckBoxTapHandler?(isDone)
    }
    @IBAction func didDelete(_ sender: UIButton) {
        doneDeleteButtonTapHandler?()
    }
    
}





extension UILabel{
    // 취소선 toggle 기능
    func strikeThrough(from text: String?, at range: String?,bool: Bool?) {
           guard let text = text,
                 let range = range,
                    let bool = bool else { return }
           
           let attributedString = NSMutableAttributedString(string: text)
        bool
        ? attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue], range: NSString(string: text).range(of: range))
        :
        attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.isEmpty], range: NSString(string: text).range(of: range))
           self.attributedText = attributedString
       }
    

}
