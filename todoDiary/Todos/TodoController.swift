//
//  TodoController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/06.
//

import UIKit

class TodoController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openModal(_ sender: UIButton) {
        performSegue(withIdentifier: "addTodo", sender: nil)
    }
    
}


extension TodoController : UICollectionViewDelegate{
    
}

extension TodoController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.layer.cornerRadius = 10.0
                cell.layer.borderWidth = 0.0
                cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
                cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.2
                cell.layer.masksToBounds = false //<-
                return cell
    }
    
    
}

extension TodoController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width:CGFloat =  collectionView.bounds.width - 30
        let height:CGFloat = 70
        
        return CGSize(width: width, height: height)
    }
    

}
