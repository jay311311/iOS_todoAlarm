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
    

}


extension TodoController : UICollectionViewDelegate{
    
}

extension TodoController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
    }
    
    
}

extension TodoController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width:CGFloat =  collectionView.bounds.width - 20
        let height:CGFloat = 80
        
        return CGSize(width: width, height: height)
    }

}
