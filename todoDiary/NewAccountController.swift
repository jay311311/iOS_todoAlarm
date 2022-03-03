//
//  NewAccountController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/04.
//

import UIKit

class NewAccountController: UIViewController {
    let vc =  UIViewController()

    @IBOutlet weak var TextFieldBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //vc.modalPresentationStyle = .fullScreen
        TextFieldBox.layer.cornerRadius=30
     
        // Do any additional setup after loading the view.
    }
    


}
