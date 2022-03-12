//
//  addTodo.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/09.
//

import UIKit

class addTodo: UIViewController {

    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var switchTable: UITableView!
    @IBOutlet weak var hashTagTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var stackHashLabel: UIStackView!
    

    let dateFormatter = DateFormatter()

    let switchTitle:[String] = ["Notification", "Important"]
    var hashTags:[Int:String] =  [:]
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegatePatterns()
        setConfigDatePicker()
        newTaskTextField.tag = 0
        hashTagTextField.tag = 1
    }
    
    func delegatePatterns(){
        self.switchTable.dataSource = self
        self.switchTable.delegate = self
        self.newTaskTextField.delegate = self
        self.hashTagTextField.delegate = self
    }
    
    @IBAction func exitAddTodo(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setTodo(_ sender: UIButton) {
        guard let todo = newTaskTextField.text, todo.isEmpty == false else { return }
       
       // print("\()")
    }
    
    
    func setConfigDatePicker(){
        datePicker.date = Date()
        dateFormatter.dateFormat = "yyyy.MM.dd"
//        dateTextField.text = "\(dateFormatter.string(from: datePicker.date))"
//        datePicker.isHidden = true
//        datePicker.setValue(UIColor.white, forKey: "backgroundColor")
       // dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(selectDate(picker: )), for: .valueChanged)
    }
    @objc func selectDate(picker: UIDatePicker){
        print("\(dateFormatter.string(from :picker.date))")
    }

}

//switchBtn_toggle위한 table view 구성
extension addTodo : UITableViewDelegate, UITableViewDataSource{
    //UITableViewDataSource
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return switchTitle.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "switchCell",for: indexPath)
    cell.textLabel?.text = switchTitle[indexPath.row]

   let switchView = setConfigSwitchBtn(indexPath: indexPath)
    cell.accessoryView = switchView
    return cell
}
    func setConfigSwitchBtn( indexPath : IndexPath)-> UISwitch{
        // switchBtn_toggle 구성
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(changeValue), for: .valueChanged)
      return switchView
    }
    
    //UITableViewDelegate
    @objc func changeValue( _ sender : UISwitch ){
        print(" switchis on ===>\(sender.isOn)")
        print(" switch tag  ===> \(sender.tag)")
    }
    
}

extension addTodo: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1{
            // 해시태그의 textField만 인식
            guard let hashTag = textField.text, hashTag.isEmpty == false else { return }
            hashTags[i] = hashTag
            let hashLabel =  paddingLabel()
            hashLabel.text = "x \(hashTag)"
            hashLabel.tag = i
            hashLabel.translatesAutoresizingMaskIntoConstraints = false
            hashLabel.font = UIFont.systemFont(ofSize: 13)
            stackHashLabel.addArrangedSubview(hashLabel)
            i += 1
            hashLabel.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeHashTag))
            hashLabel.addGestureRecognizer(tapGestureRecognizer)
            }
    }
    
    @objc func removeHashTag(sender: UITapGestureRecognizer){
        guard hashTags.isEmpty == false else { return }
        hashTags.map { hash  in
            if sender.view?.tag == hash.key{
                sender.view!.removeFromSuperview()
                hashTags.removeValue(forKey:hash.key)
                print("\(hash.value)을 지우겠습니다+\(hashTags)")
            }
        }
    }
    
}


class paddingLabel: UILabel {
    @IBInspectable var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 0)

    override func drawText(in rect: CGRect) {
        let paddingRect = rect.inset(by: padding)
        super.drawText(in: paddingRect)
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}