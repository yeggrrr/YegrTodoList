//
//  TodoListTableViewController.swift
//  YegrTodoList
//
//  Created by YJ on 5/23/24.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    @IBOutlet var todoListTableView: UITableView!
    @IBOutlet var todoInputBackgroundView: UIView!
    @IBOutlet var inputTodoTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var todo = ["그립톡 구매하기", "사이다 구매", "아이패드 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        todoInputBackgroundView.backgroundColor = .systemGray5
        todoInputBackgroundView.layer.cornerRadius = 10
        
        inputTodoTextField.placeholder = "무엇을 구매하실 건가요?"
        inputTodoTextField.tintColor = .lightGray
        inputTodoTextField.keyboardType = .default
        inputTodoTextField.returnKeyType = .done
        inputTodoTextField.layer.cornerRadius = 10
        
        addButton.backgroundColor = .white
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.layer.cornerRadius = 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = todo[indexPath.row]
        
        return cell
    }
    // 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // 추가
    @IBAction func addButtonClicked(_ sender: UIButton) {
        guard let newTodo = inputTodoTextField.text else { return }
        todo.append(newTodo)
        todoListTableView.reloadData()
    }
}



