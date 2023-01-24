//
//  HomeVC.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import UIKit
import UIScrollView_InfiniteScroll

class HomeVC: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: HomeVM!
    
    var dailys = [DailyModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.getData()
        
        let homeCell = UINib(nibName: "HomeCell", bundle: nil)
        collectionView.register(homeCell, forCellWithReuseIdentifier: "homeCell")
        
        title = "Günlük"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        collectionView.infiniteScrollDirection = .vertical
        collectionView.addInfiniteScroll { tableView in
            self.viewModel.getData()
            self.collectionView.reloadData()
            self.collectionView.finishInfiniteScroll()
        }
    }

}

extension HomeVC{
    static func create() -> HomeVC {
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        vc.viewModel = HomeVM()
        return vc
    }
    
    @objc private func addButtonClicked(){
        let createDailyVC = CreateDailyVC.create()
        navigationController?.pushViewController(createDailyVC, animated: true)
     }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dailys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCell
        let data = viewModel.dailys[indexPath.row]
        cell.configure(daily: data)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.dailys[indexPath.row]
        let detailsVC = DetailsVC.create(daily: data)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    }
