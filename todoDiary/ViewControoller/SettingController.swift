//
//  SettingViewController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/04/11.
//

import UIKit

class SettingController: UIViewController {
    let todoListViewModel = TodoViewModel()

    
    @IBOutlet weak var tableView: UITableView!
    var settingItems = [ "전체 데이터 삭제","PUSH 알림"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension SettingController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingCellController  else  { return UITableViewCell() }
        cell.SettingTitle.text = settingItems[indexPath.row]
        if settingItems[indexPath.row] == settingItems[1] {
            cell.datePickerUI()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if indexPath.row == 0 {
            let alert = UIAlertController(title: "모든데이터를 삭제하겠습니까?", message: " 할 일과 지난 일이 모두 삭제됩니다 ", preferredStyle: UIAlertController.Style.alert)
                    
            let okAction = UIAlertAction(title: "삭제하기", style: .destructive) { click in
                            }
                    let later = UIAlertAction(title: "나중에", style: .default, handler : nil)
                    
                    
                    alert.addAction(later)
                    alert.addAction(okAction)
              
                    present(alert, animated: true, completion: nil)
                    
                    }
        }
    }
    
  



class SettingCellController : UITableViewCell {
    
    var todoListViewModel = TodoViewModel()
    var manager =  TodoManager.shared

    @IBOutlet weak var SettingTitle: UILabel!
    var handlerNotificationTime : (()->Void)?
    var datePicker = UIDatePicker()
    func datePickerUI(){
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        print("여기서는? \(datePicker.date)")
        self.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        datePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
    }
    
   
    
    @objc func changeTime(){
        var changeTime = datePicker.date
        var date:String = todoListViewModel.setKoreanDate(date: changeTime)
        print("여기는 어떠냐?\(date)")
        date = date.components(separatedBy: " ")[1]
        UserDefaults.standard.set(date, forKey: "notificationTime")
    }
    
    
}
