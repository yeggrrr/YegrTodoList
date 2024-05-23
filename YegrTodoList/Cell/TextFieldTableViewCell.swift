//
//  TextFieldTableViewCell.swift
//  YegrTodoList
//
//  Created by YJ on 5/24/24.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    static let identifier = "textFieldCell"
    
    weak var delegate: AddButtonDelegate?
    
    @IBOutlet var inputTodoTextField: UITextField!
    @IBOutlet var addButton: UIButton!
   
    @IBAction func addButtonClicked(_ sender: UIButton) {
        delegate?.addButtonClicked(textField: inputTodoTextField)
    }
}
