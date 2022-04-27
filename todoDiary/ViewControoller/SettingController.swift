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
    var settingItems = [ "전체 데이터 삭제","알림 시간 변경"]
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
            print(settingItems[1])
            cell.datePickerUI()
          //  datePicker.addTarget(self, action: #selector(cell.setTime), for: .valueChanged)
           
           
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
    
    @IBOutlet weak var SettingTitle: UILabel!
   // var time:Date = Date()
    var handlerNotificationTime : (()->Void)?
    var datePicker = UIDatePicker()
    func datePickerUI(){
       // var datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        self.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        datePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
    }
    
   
    
    @objc func changeTime(){
        print(datePicker.date)
    }
    
    
}
