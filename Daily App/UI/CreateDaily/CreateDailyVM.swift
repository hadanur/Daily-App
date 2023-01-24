//
//  CreateDailyVM.swift
//  Daily App
//
//  Created by Hakan Adanur on 19.01.2023.
//

import Foundation
import UIKit

protocol CreateDailyVMDelegate: AnyObject{
    func saveSuccess()
    func saveError()
}

class CreateDailyVM{
    weak var delegate: CreateDailyVMDelegate?
    
    func saveDaily(title: String, overview: String, day: String, image: UIImage){
        if CoreDataManager.shared.saveDaily(title: title, overview: overview, day: day, image: image) == true {
            delegate?.saveSuccess()
        } else {
            delegate?.saveError()
        }
    }
}
