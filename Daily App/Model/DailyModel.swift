//
//  DailyModel.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import Foundation

struct DailyModel: Codable {
    let id : UUID
    let title: String
    let overview: String
    let day: String
    let image: Data
}
