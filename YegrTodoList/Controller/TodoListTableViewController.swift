//
//  TodoListTableViewController.swift
//  YegrTodoList
//
//  Created by YJ on 5/23/24.
//

import UIKit


class TodoListTableViewController: UITableViewController {
    @IBOutlet var todoListTableView: UITableView!
 
    var data = DataStorage.shared.todoList
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func checkButtonClicked(sender: UIButton) {
        data[sender.tag].check.toggle()
        tableView.reloadData()
    }
    
    @objc func starButtonClicked(sender: UIButton) {
        data[sender.tag].star.toggle()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return data.count
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
            let checkImageName = data[indexPath.row].check ? "checkmark.square.fill" : "checkmark.square"
            let checkImage = UIImage(systemName: checkImageName)
            cell.checkButton.setImage(checkImage, for: .normal)
            cell.checkButton.tintColor = .black
            cell.checkButton.tag = indexPath.row
            cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
            
            cell.titleLabel.text = data[indexPath.row].title
            cell.titleLabel.textColor = .black
            cell.titleLabel.font = .systemFont(ofSize: 17)
            
            let starImageName = data[indexPath.row].star ? "star.fill" : "star"
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if editingStyle == .delete {
                data.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension TodoListTableViewController: AddButtonDelegate {
    func addButtonClicked(textField: UITextField) {
        guard let newTitle = textField.text else { return }
        let newTodo = DataStorage.Todo(check: false, title: newTitle, star: false)
        
        if newTitle == "" {
            let alert = UIAlertController(title: "구매하실 품목을 입력해주세요!", message: "", preferredStyle: .alert)
            let checkButton = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(checkButton)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "'\(newTitle)'을 추가하시겠습니까?", message: "", preferredStyle: .alert)
            let registerButton = UIAlertAction(title: "추가", style: .default) { _ in
                self.data.append(newTodo)
                self.todoListTableView.reloadData()
                // UserDefault - key: "add"
                textField.text = ""
            }
            let cancelButton = UIAlertAction(title: "취소", style: .cancel) { _ in
                textField.text = ""
            }
            alert.addAction(registerButton)
            alert.addAction(cancelButton)
            present(alert, animated: true)
        }
    }
}

protocol AddButtonDelegate: AnyObject {
    func addButtonClicked(textField: UITextField)
}
