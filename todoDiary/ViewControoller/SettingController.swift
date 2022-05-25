import UIKit

class SettingController: UIViewController {
    let todoListViewModel = TodoViewModel()
    
    @IBOutlet weak var popupBox: UIView!
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var popupHeader: UIView!
    @IBOutlet weak var popupLabel: UILabel!
    var popupIsHide: Bool  = true
    
    @IBOutlet weak var tableView: UITableView!
    var settingItems = [ "알림 설정","알림 시간"]
    override func viewDidLoad() {
        popupBox.isHidden = popupIsHide
        super.viewDidLoad()
        definesPresentationContext = true
        popupHeader.layer.cornerRadius = 10.0
        popupHeader.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    @IBAction func tapPopupHide(_ sender: Any) {
        popupBox.isHidden = !popupBox.isHidden
    }
    
    @IBAction func tapPopupClose(_ sender: Any) {
        popupBox.isHidden = !popupBox.isHidden
    }
    
}

extension SettingController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingCellController  else  { return UITableViewCell() }
        
        cell.handlerPopupContent = { date in
            self.popupBox.isHidden = !self.popupIsHide
            var time = date.components(separatedBy: " ")[1]
            self.popupLabel.text = "당일 \(time) 알림이 도착합니다 "
        }
        cell.SettingTitle.text = settingItems[indexPath.row]
        if settingItems[indexPath.row] == settingItems[1] {
            cell.datePickerUI()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print(indexPath.row)
        if indexPath.row == 0 {
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
    
class SettingCellController : UITableViewCell {
    
    var todoListViewModel = TodoViewModel()
    var manager =  TodoManager.shared

    @IBOutlet weak var SettingTitle: UILabel!

    var handlerPopupContent : ((String)->Void)?
    var datePicker = UIDatePicker()
    
    func datePickerUI(){
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
      //  print("여기서는? \(datePicker.date)")
        self.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        datePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        datePicker.addTarget(self, action: #selector(endChangeTime), for: .editingDidEnd)

    }
    
   
    
    @objc func changeTime(){
        let changeTime = datePicker.date
        var date:String = todoListViewModel.setKoreanDate(date: changeTime)
       // print("여기는 어떠냐?\(date)")
        date = date.components(separatedBy: " ")[1]
        UserDefaults.standard.set(date, forKey: "notificationTime")
    }
    
    @objc func endChangeTime(){
        let changeTime = datePicker.date
        let date:String = todoListViewModel.setKoreanDate(date: changeTime)
       print("모든 할일은 해당날짜 \(date)에 알림메세지가 도착합니다")
        handlerPopupContent?(date)

       
    }
    
    
}
