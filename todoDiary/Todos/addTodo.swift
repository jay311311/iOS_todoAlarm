//
//  addTodo.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/09.
//

import UIKit

class addTodo: UIViewController {

    let switchTitle:[String] = ["Notification", "Important"]
    
    @IBOutlet weak var switchTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchTable.dataSource = self
        self.switchTable.delegate = self

        // Do any additional setup after loading the view.
    }
    

    @IBAction func exitAddTodo(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   

}

extension addTodo : UITableViewDelegate, UITableViewDataSource{
    
  

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return switchTitle.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "switchCell",for: indexPath)
    cell.textLabel?.text =  String(indexPath.row)
    
    // switch view
    let switchView = UISwitch(frame: .zero)
    switchView.setOn(false, animated: true)
    switchView.tag = indexPath.row
    switchView.addTarget(self, action: #selector(changeValue), for: .valueChanged)
    
    cell.accessoryView = switchView
    return cell

}
    
    @objc func changeValue( _ sender : UISwitch ){
        print(" switchis on ===>\(sender.isOn)")
        print(" switch tag  ===> \(sender.tag)")
    }

    
}


