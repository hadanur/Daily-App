//
//  CreateDailyVC.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import UIKit

class CreateDailyVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: CreateDailyVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let createCell = UINib(nibName: "CreateCell", bundle: nil)
        tableView.register(createCell, forCellReuseIdentifier: "CreateCell")
        
        title = "Günlük Oluştur"
        viewModel.delegate = self

    }
    
}

extension CreateDailyVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCell") as! CreateCell
        cell.configure()
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

extension CreateDailyVC {
    static func create() -> CreateDailyVC {
        let vc = CreateDailyVC(nibName: "CreateDailyVC", bundle: nil)
        vc.viewModel = CreateDailyVM()
        return vc
    }
}

extension CreateDailyVC: CreateCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func error() {
        self.showAlert(title: "Hata", message: "Tekrar Dene")
    }
    
    func saveButtonClicked(title: String, overview: String, day: String, image: UIImage) {
        viewModel.saveDaily(title: title, overview: overview, day: day, image: image)
        navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func showPhotoLibrary(_ pickerImageController: UIImagePickerController) {
        present(pickerImageController, animated: true)
    }
    
    func closePhotoLibrary() {
        self.dismiss(animated: true)
    }
}

extension CreateDailyVC: CreateDailyVMDelegate{
    func saveSuccess() {
        self.tableView.reloadData()
    }
    
    func saveError() {
        self.showAlert(title: "Error", message: "")
    }
    
    
}
