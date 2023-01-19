//
//  HomeCell.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import Foundation
import UIKit

class HomeCell: UICollectionViewCell{
    @IBOutlet private weak var dailyImage: UIImageView!
    @IBOutlet private weak var dailyTitle: UILabel!
    @IBOutlet private weak var dailyDate: UILabel!
    @IBOutlet private weak var dailyVisual: UIVisualEffectView!
    @IBOutlet private weak var dailyView: UIView!
    
    func configure(daily: DailyModel) {
        dailyImage.image = UIImage(data: daily.image)
        dailyTitle.text = daily.title
        dailyDate.text = daily.day
        
    }
}
