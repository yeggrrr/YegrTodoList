//
//  DataStorage.swift
//  YegrTodoList
//
//  Created by YJ on 5/24/24.
//

import Foundation

class DataStorage {
    static let shared = DataStorage()
    
    struct Todo {
        var check: Bool
        let title: String
        var star: Bool
    }

    var todoList = [
        Todo(check: false, title: "그립톡 구매하기", star: false),
        Todo(check: false, title: "제로 콜라 구매", star: false),
        Todo(check: false, title: "아이패드 최저가 알아보기", star: false),
        Todo(check: false, title: "양말", star: false)]
}
