//
//  TodoCellController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/07.
//

import UIKit

class TodoCellController: UICollectionViewCell {
    
    @IBOutlet weak var hashTagBox: UIView!
    
    @IBOutlet weak var hashTagLabel: UILabel!
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var star: UIButton!
    
    @IBOutlet weak var bell: UIButton!
    
    @IBOutlet weak var checkBox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


    
    
}
