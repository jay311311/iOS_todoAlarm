//
//  TodoCellController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/07.
//

import UIKit

class TodoCellController: UICollectionViewCell  {
    
    @IBOutlet weak var hashLabelBox: UIStackView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var bell: UIButton!
    @IBOutlet weak var checkBox: UIButton!

   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func touchStar(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            star.tintColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0)
            TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 1, category: "important")
        }else{
           star.tintColor = .lightGray
            TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 0, category: "important")
        }
    }
    
    @IBAction func touchBell(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            bell.tintColor = UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0)
            TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 1, category: "notification")
        }else{
           bell.tintColor = .lightGray
            TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 0, category: "notification")
        }
    }
    

    @IBAction func didTodo(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            bell.isEnabled = false
            star.isEnabled = false
            cellTitle.strikeThrough(from: cellTitle.text, at: cellTitle.text, bool: sender.isSelected)
            cellTitle.textColor = UIColor(white: 75/100, alpha: 1.0)
            checkBox.setImage(UIImage(systemName: "checkmark",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold, scale: .large)), for: .normal)
            checkBox.tintColor = UIColor(red: 53/255, green: 110/255, blue: 253/255, alpha: 1.0)
            TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 1, category: "todo_done")
        }else{
             bell.isEnabled = true
             star.isEnabled = true
            cellTitle.strikeThrough(from: cellTitle.text, at: cellTitle.text, bool: sender.isSelected)
            cellTitle.textColor = UIColor(red: 10/225, green: 27/225, blue: 57/225, alpha: 1.0)
            checkBox.setImage(UIImage(systemName: "square"), for: .normal)
            checkBox.tintColor = .lightGray
            TodoController().dataUpdate(id: sender.accessibilityIdentifier, element: 0, category: "todo_done")
        }
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
