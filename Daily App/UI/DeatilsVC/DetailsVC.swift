//
//  DetailsVC.swift
//  Daily App
//
//  Created by Hakan Adanur on 19.01.2023.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet private weak var detailsImage: UIImageView!
    @IBOutlet private weak var detailsTitle: UILabel!
    @IBOutlet private weak var detailsDate: UILabel!
    @IBOutlet private weak var detailsDescription: UILabel!
    
    private var daily: DailyModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsImage.image = UIImage(data: daily.image)
        detailsTitle.text = daily.title
        detailsDescription.text = daily.overview
        detailsDate.text = daily.day
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailsVC{
    static func create(daily: DailyModel) -> DetailsVC {
        let vc = DetailsVC(nibName: "DetailsVC", bundle: nil)
        vc.daily = daily
        return vc
    }
}
