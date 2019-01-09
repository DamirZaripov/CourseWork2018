//
//  ToDoTableViewCell.swift
//  CourseWork
//
//  Created by Damir Zaripov on 19/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameToDo: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    var onToDoButtonClicked: (() -> Void)?
 
    func config(with todo: ToDo) {
        self.nameToDo.text = todo.name
        
        if (todo.checked) {
            self.resultButton.setImage(UIImage(named: "iconToDoYes"), for: .normal)
        } else {
            self.resultButton.setImage(UIImage(named: "iconToDoNo"), for: .normal)
        }
    }
    
    func changeButtonImage() {
        let image = resultButton.image(for: UIControl.State.normal)
        if (image!.isEqualToImage(image: UIImage(named: "iconToDoYes")!)) {
            self.resultButton.setImage(UIImage(named: "iconToDoNo"), for: .normal)
        } else {
            self.resultButton.setImage(UIImage(named: "iconToDoYes"), for: .normal)
        }
    }
    
    @IBAction func onToDoButtonTouchUpInside(_ sender: Any) {
        self.onToDoButtonClicked?()
    }
}
