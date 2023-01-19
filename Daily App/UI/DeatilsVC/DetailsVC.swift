//
//  DetailsVC.swift
//  Daily App
//
//  Created by Hakan Adanur on 19.01.2023.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsDate: UILabel!
    @IBOutlet weak var detailsDescription: UILabel!
    
    private var daily: DailyModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsImage.image = UIImage(data: daily.image)
        detailsTitle.text = daily.title
        detailsDescription.text = daily.overview
        detailsDate.text = daily.day
    }

    @IBAction func backButtonClicked(_ sender: Any) {
    }
}

extension DetailsVC{
    static func create(daily: DailyModel) -> DetailsVC {
        let vc = DetailsVC(nibName: "DetailsVC", bundle: nil)
        vc.daily = daily
        return vc
    }
}
