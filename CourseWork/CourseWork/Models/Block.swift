//
//  Block.swift
//  CourseWork
//
//  Created by Damir Zaripov on 18/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import Foundation

struct Block: Codable {
    var id: Int
    var name: String
    var semestrNumber: Int
    var blockNumber: Int
    let courses: [Course]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case semestrNumber = "sem_num"
        case blockNumber = "block_in_sem_num"
        case courses = "courses"
    }
    
}

struct Course: Codable {
    var id: Int
    var selected: Bool
    var percents: Int
    var name: String
    var description: String
    var teacher: String
    var imageURL: URL?
    var semestrNumber: Int
    var blockNumber: Int
    var todo: [ToDo]
    var spells: [Spell]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case selected = "selected"
        case percents = "percents"
        case name = "name"
        case description = "description"
        case teacher = "teacher"
        case imageURL = "image_url"
        case semestrNumber = "sem_num"
        case blockNumber = "block_in_sem_num"
        case todo = "todos"
        case spells = "spells"
    }
}

struct ToDo: Codable {
    var id: Int
    var name: String
    var description: String
    var checked: Bool
}

struct Spell: Codable {
    var id: Int
    var name: String
    var description: String
    var has: Bool
    var level: Int
}
