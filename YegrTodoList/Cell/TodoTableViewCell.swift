//
//  TodoTableViewCell.swift
//  YegrTodoList
//
//  Created by YJ on 5/23/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    static let identifier = "yegrTodoCell"
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var starButton: UIButton!
}
