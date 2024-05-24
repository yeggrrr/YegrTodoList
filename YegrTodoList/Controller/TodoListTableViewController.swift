//
//  TodoListTableViewController.swift
//  YegrTodoList
//
//  Created by YJ on 5/23/24.
//

import UIKit

struct Todo {
    var check: Bool
    let title: String
    var star: Bool
}

class TodoListTableViewController: UITableViewController {
    @IBOutlet var todoListTableView: UITableView!
    
    var todoList = [
        Todo(check: false, title: "그립톡 구매하기", star: false),
        Todo(check: false, title: "제로 콜라 구매", star: false),
        Todo(check: false, title: "아이패드 최저가 알아보기", star: false),
        Todo(check: false, title: "양말", star: false),
    ]
    
    @objc func checkButtonClicked(sender: UIButton) {
        todoList[sender.tag].check.toggle()
        tableView.reloadData()
    }
    
    @objc func starButtonClicked(sender: UIButton) {
        todoList[sender.tag].star.toggle()
        tableView.reloadData()
    }
    
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
            return todoList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            cell.inputTodoTextField.placeholder = "구매하실 품목을 입력해주세요."
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
            
            let checkImageName = todoList[indexPath.row].check ? "checkmark.square.fill" : "checkmark.square"
            let checkImage = UIImage(systemName: checkImageName)
            cell.checkButton.setImage(checkImage, for: .normal)
            cell.checkButton.tintColor = .black
            cell.checkButton.tag = indexPath.row
            cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
            
            cell.titleLabel.text = todoList[indexPath.row].title
            cell.titleLabel.textColor = .black
            cell.titleLabel.font = .systemFont(ofSize: 17)
            
            let starImageName = todoList[indexPath.row].star ? "star.fill" : "star"
            let starImage = UIImage(systemName: starImageName)
            cell.starButton.setImage(starImage, for: .normal)
            cell.starButton.tintColor = .systemRed
            cell.starButton.tag = indexPath.row
            cell.starButton.addTarget(self, action: #selector(starButtonClicked), for: .touchUpInside)
            
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
                todoList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension TodoListTableViewController: AddButtonDelegate {
    func addButtonClicked(textField: UITextField) {
        guard let newTitle = textField.text else { return }
        let newTodo = Todo(check: false, title: newTitle, star: false)
        todoList.append(newTodo)
        todoListTableView.reloadData()
        textField.text = ""
    }
}

protocol AddButtonDelegate: AnyObject {
    func addButtonClicked(textField: UITextField)
}

