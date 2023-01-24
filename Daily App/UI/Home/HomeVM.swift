//
//  HomeVM.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import Foundation
import UIKit
import CoreData

protocol HomeVMDelegate: AnyObject{
    func bringDataOnSuccess()
    func bringDataOnError()
    func deleteDataOnSuccess(at index: Int)
    func deleteDataOnError()
}


class HomeVM {
    var dailys = [DailyModel]()
    var delegate: HomeVMDelegate?
    
    func getData(){
        if let dailys = CoreDataManager.shared.getData() {
            self.dailys = dailys
            delegate?.bringDataOnSuccess()
        }
    }

    func deleteData(from data: [DailyModel], at index: Int) {
        if CoreDataManager.shared.deleteDaily(from: data, at: index) {
            delegate?.deleteDataOnSuccess(at: index)
        } else {
            delegate?.deleteDataOnError()
        }
    }

}
