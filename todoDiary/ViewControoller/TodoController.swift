import UIKit
import UserNotifications

class TodoController: UIViewController {

    @IBOutlet weak var todoCollectionVIew: UICollectionView!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    @IBOutlet weak var inputTextField : UITextField!
    @IBOutlet weak var calendarBtn :UIButton!
    @IBOutlet weak var addBtn :UIButton!
    @IBOutlet weak var datePickerView : UIView!
    @IBOutlet weak var datePicker : UIDatePicker!
    
    let todoListViewModel = TodoViewModel()
    
    var todoDate : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoListViewModel.loadTask()
        let nowDate:Date = Date()
        todoDate = todoListViewModel.setKoreanDate(date: nowDate)
        datePickerView.isHidden = true
        todoDate =   saveTodoDate(date: todoDate)

        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        
        // 1. ask for permission
        let center  =  UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            print(granted)
            UserDefaults.standard.set(granted, forKey: "notificationPermission")
        }
    }
    @IBAction func tapCalendarButton(_ sender: Any) {
        // keyboard 안보이게 처리
        inputTextField.resignFirstResponder()
        inputViewBottom.constant =  0
        
        //isSelected에 따른 ui 하단 변화
        calendarBtn.isSelected = !calendarBtn.isSelected
        calendarBtn.tintColor = calendarBtn.isSelected ? .tintColor : .lightGray
        datePickerView.isHidden = !calendarBtn.isSelected
        inputViewBottom.constant = calendarBtn.isSelected ? datePickerView.bounds.height : 0
        datePicker.minimumDate =  Date()
    }
    
    @IBAction func tapAddTaskButton(_ sender: Any) {
        addBtn.isSelected = !addBtn.isSelected
        // inputview에 글자가 있는지 확인
        guard let detail =  inputTextField.text , detail.isEmpty == false else { return }
        let todo =  TodoManager.shared.createTodo(title: detail, date: todoDate)
        todoListViewModel.addTodo(todo)
        todoCollectionVIew.reloadData()
        inputTextField.text = ""
        inputTextField.resignFirstResponder()
        calendarBtn.isSelected = false
        inputViewBottom.constant =  0
        datePickerView.isHidden = true
    }
    
    @IBAction func tapBG(_ sender: Any) {
        inputTextField.resignFirstResponder()
        calendarBtn.isSelected =  false
        datePickerView.isHidden = true
        inputViewBottom.constant =  0
    }
    
    func saveTodoDate(date: String) -> String {
        var date = date
        date = date.components(separatedBy: " ")[0]
        date = "\(date) 23:59:59 +000"
        return date
    }
    
   @objc  func changeDate (){
       let datePicker = datePicker.date
       let koreanDate = todoListViewModel.setKoreanDate(date: datePicker)
       todoDate = saveTodoDate(date: koreanDate)
    }

}

extension TodoController{
    @objc private func adjustInputView (noti : Notification){
        guard let userInfo = noti.userInfo else  { return }
        guard let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        datePickerView.isHidden = true

        if noti.name ==  UIResponder.keyboardWillShowNotification{
            let adjustmentHeight = keyboardFrame.height -  view.safeAreaInsets.bottom
            inputViewBottom.constant =  adjustmentHeight
            
        }else {
            inputViewBottom.constant =  0
        }
    }
    // 키보드에  높이에 따른 인풋뷰 위치 변경
}

extension TodoController : UICollectionViewDataSource,  UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //todo : 섹션 아이템 몇개
           return todoListViewModel.soonTodos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TodoCellController else {
            return UICollectionViewCell()
        }
        cell.viewController = self
        var todo : Todo =  todoListViewModel.soonTodos[indexPath.item]
                cell.updateUI(todo: todo)
            
            cell.doneCheckBoxTapHandler = { isDone in
                todo.isDone = isDone
                self.todoListViewModel.updateTodo(todo)
                self.todoCollectionVIew.reloadItems(at: [indexPath])
            }
            
            cell.doneDeleteButtonTapHandler = {
                self.todoListViewModel.deleteTodo(todo)
                self.todoCollectionVIew.reloadItems(at: [indexPath])
            }
            
            cell.doneStarTapHandler = { isImportant in
                todo.isImportant = isImportant
                self.todoListViewModel.updateTodo(todo)
                self.todoCollectionVIew.reloadItems(at: [indexPath])
            }
            cell.doneBellTapHandler = { isNotification in
                todo.isNotification =  isNotification
                let notificationTime:String = UserDefaults.standard.string(forKey: "notificationTime")!
                let dateSlice:String = todo.date.components(separatedBy: " ")[0]
                //print("\(dateSlice) \(notificationTime)+0000 에 push알림 됩니다")
                self.todoListViewModel.setNotificationTime(todo, date:"\(dateSlice) \(notificationTime) +0000", identifier: todo.id, isNotification: isNotification)
                self.todoListViewModel.updateTodo(todo)
                self.todoCollectionVIew.reloadItems(at: [indexPath])
            }

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

class TodoCellController: UICollectionViewCell  {
    
    @IBOutlet weak var swipeBox: UIStackView!
    @IBOutlet weak var cellBox : UIView!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var bell: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    weak var viewController: UIViewController?

   // view객체의 메소드가 다른 비지니스 로직에까지 영향을 주지 않기위해 클로저 사용
    var doneBellTapHandler : ((Bool)->Void)?
    var doneStarTapHandler : ((Bool)->Void)?
    var doneCheckBoxTapHandler : ((Bool)->Void)?
    var doneDeleteButtonTapHandler : (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configSwipeBtn()
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.zPosition = 1
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    func updateUI(todo : Todo){
            // 셀 업데이트 하기
            checkBox.isSelected = todo.isDone
            cellDate.text = todo.date.components(separatedBy: " ")[0]
            cellTitle.text = todo.title
            cellTitle.alpha = todo.isDone ? 0.2 : 1
            cellDate.alpha = todo.isDone  ? 0.5 : 1
            cellBox.backgroundColor = todo.isImportant ? UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0) : .white
            cellTitle.strikeThrough(from: todo.title, at: todo.title, bool: todo.isDone)
            star.isSelected =  todo.isImportant
            bell.isSelected =  todo.isNotification
            star.isEnabled = !todo.isDone
            bell.isEnabled = !todo.isDone
            bell.tintColor =  todo.isNotification ? UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0) : .lightGray
            star.tintColor =  todo.isImportant ? .white : .lightGray
    }

    func reset(){
        let width =  cellBox.bounds.size.width
        let height = cellBox.bounds.size.height
        cellTitle.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseOut, animations: {
            self.cellBox.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        }, completion: nil)
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
            let width =  cellBox.bounds.size.width
            let height = cellBox.bounds.size.height
            let swipeBoxWidth = swipeBox.bounds.size.width
            switch sender.direction{
            case .left :
                UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseOut, animations: {
                    self.cellBox.frame = CGRect(x: -swipeBoxWidth, y: 0.0, width: width, height: height)
                }, completion: nil)
            case .right:
                UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseOut, animations: {
                    self.cellBox.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
                }, completion: nil)
            default:break
            }
        
    }
  
    
    @IBAction func touchStar(_ sender: UIButton) {
        star.isSelected = !star.isSelected
        let isImportant = star.isSelected
        cellBox.backgroundColor = star.isSelected ? UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0) : .white
        star.tintColor = star.isSelected ? .white : .lightGray
        doneStarTapHandler?(isImportant)
    }
    
    @IBAction func touchBell(_ sender: UIButton) {
        let notificationPermission =  UserDefaults.standard.bool(forKey: "notificationPermission")
        if notificationPermission{
            bell.isSelected = !bell.isSelected
            let isNotification = bell.isSelected
            bell.tintColor   = bell.isSelected ? UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0): .lightGray
            let notiTime:String? =  UserDefaults.standard.string(forKey: "notificationTime")
            if notiTime == nil{
                let alert = UIAlertController(title: "push 알림 시간 요청", message: "설정 > 알림 시간을 설정해 주세요", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                viewController?.present(alert, animated: true, completion: nil)
            }else {
                doneBellTapHandler?(isNotification)
            }
        }else {
            let alert = UIAlertController(title: "push 알림 설정 요청", message: "설정 > 앱 > 알림 설정을 수락해 주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTodo(_ sender: UIButton) {
        checkBox.isSelected = !checkBox.isSelected
        let isDone = checkBox.isSelected
        bell.isEnabled = !isDone
        star.isEnabled = !isDone
        cellTitle.alpha = isDone  ? 0.2 : 1
        cellDate.alpha = isDone  ? 0.5 : 1
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
           guard let text = text, let range = range, let bool = bool else { return }
           let attributedString = NSMutableAttributedString(string: text)
        
        bool
        ? attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue], range: NSString(string: text).range(of: range))
        :
        attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.isEmpty], range: NSString(string: text).range(of: range))
           self.attributedText = attributedString
       }
}
