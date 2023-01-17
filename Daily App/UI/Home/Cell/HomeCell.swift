//
//  HomeCell.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import Foundation
import UIKit

class HomeCell: UICollectionViewCell{
    @IBOutlet weak var dailyImage: UIImageView!
    @IBOutlet weak var dailyTitle: UILabel!
    @IBOutlet weak var dailyDate: UILabel!
    @IBOutlet weak var dailyVisual: UIVisualEffectView!
    @IBOutlet weak var dailyView: UIView!
    
    func configure(daily: DailyModel) {
        
    }
}
