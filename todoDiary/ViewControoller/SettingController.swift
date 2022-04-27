//
//  SettingViewController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/04/11.
//

import UIKit

class SettingController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var settingItems = ["알림 시간 변경", "전체 데이터 삭제"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension SettingController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingCellController  else  { return UITableViewCell() }
        cell.SettingTitle.text = settingItems[indexPath.row]
        return cell
    }
  

}

class SettingCellController : UITableViewCell {
    
    @IBOutlet weak var SettingTitle: UILabel!
    
    
}
