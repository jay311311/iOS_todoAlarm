//
//  TodoCellController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/07.
//

import UIKit

class TodoCellController: UICollectionViewCell {
    
    
    @IBOutlet weak var hashLabelBox: UIStackView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var bell: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    
    
    override func awakeFromNib() {
       // print(hashLabelBox.arrangedSubviews.count)
        super.awakeFromNib()
        checkBtnState()
    }
    
    func checkBtnState(){
        
    }
    
    @IBAction func touchStar(_ sender: UIButton) {
        sender.isSelected.toggle()
        print("종 --->\(sender.responds(to: nil)) && \(sender.isSelected) && \(sender.isTouchInside)")
        if sender.isSelected == true{
            sender.tintColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1.0)
        }else {
            sender.tintColor = .lightGray
        }
        print(sender.accessibilityIdentifier!)
        
    }
    

    @IBAction func didTodo(_ sender: UIButton) {
        print("체크박스 --> \(sender.currentTitleColor) && \(sender.isSelected) && \(sender.isTouchInside)")
        sender.isSelected.toggle()
        
    }
    
    //    override class func awakeFromNib() {
    //        super.awakeFromNib()
    //    }
    
    //    override func setSelected(_ selected :Bool, animated: Bool ){
    //        super.setSelected(selected, animated: animated)
    //    }
    
    
    
    
}
