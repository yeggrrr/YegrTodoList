//
//  TodoListTableViewController.swift
//  YegrTodoList
//
//  Created by YJ on 5/23/24.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    @IBOutlet var todoListTableView: UITableView!
    
    var todo = ["그립톡 구매하기", "사이다 구매", "아이패드 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return todo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.inputTodoTextField.placeholder = "무엇을 구매하실 건가요?"
            cell.inputTodoTextField.tintColor = .lightGray
            cell.inputTodoTextField.keyboardType = .default
            cell.inputTodoTextField.returnKeyType = .done
            cell.inputTodoTextField.layer.cornerRadius = 10
            cell.addButton.backgroundColor = .systemGray6
            cell.addButton.setTitle("추가", for: .normal)
            cell.addButton.setTitleColor(.black, for: .normal)
            cell.addButton.layer.cornerRadius = 10
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = todo[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
    
    // 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if editingStyle == .delete {
                todo.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension TodoListTableViewController: AddButtonDelegate {
    func addButtonClicked(textField: UITextField) {
        guard let newTodo = textField.text else { return }
        todo.append(newTodo)
        todoListTableView.reloadData()
        textField.text = ""
    }
}

protocol AddButtonDelegate: AnyObject {
    func addButtonClicked(textField: UITextField)
}
