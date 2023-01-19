//
//  CreateCell.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import Foundation
import UIKit

protocol CreateCellDelegate: AnyObject{
    func saveButtonClicked(title: String, overview: String, day: String, image: UIImage)
    func cancelButtonClicked()
    func showPhotoLibrary(_ pickerImageController: UIImagePickerController)
    func closePhotoLibrary()
    func error()
}

class CreateCell: UITableViewCell{
    @IBOutlet private weak var dailyImage: UIImageView!
    @IBOutlet private weak var dailyTitle: UITextField!
    @IBOutlet private weak var dailyDescriptionView: UITextView!
    @IBOutlet private weak var dailyDate: UITextField!
    @IBOutlet private weak var dailyView: UIView!
    
    var viewModel: CreateDailyVM!
    weak var delegate: CreateCellDelegate?
    
    func configure(){
        dailyDescriptionView.layer.borderWidth = 0.55
        dailyDescriptionView.layer.cornerRadius = 4
        dailyDescriptionView.layer.borderColor = CGColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.15)
        
        dailyImage.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectDailyImage))
        dailyImage.addGestureRecognizer(imageTapRecognizer)
        
        createDatePicker()
    }
    
    private func createDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        dailyDate.inputAccessoryView = toolbar
        dailyDate.inputView = datePicker
    }
    
    
    @objc private func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM EEEE yyyy"
        dailyView.endEditing(true)
    }
    
    @objc private func cancelDatePicker(){
        dailyView.endEditing(true)
        
    }
    
    @objc private func dateChange(datePicker: UIDatePicker){
        dailyDate.text = formatDate(date: datePicker.date)
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "d MMMM EEEE yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let title = dailyTitle.text,
              let overview = dailyDescriptionView.text,
              let day = dailyDate.text,
              let image = dailyImage.image else { delegate?.error()
            return
        }
        
        if dailyTitle.text != "",
           dailyImage.image != nil,
           dailyDescriptionView.text != "",
           dailyDate.text != "" {
            delegate?.saveButtonClicked(title: title, overview: overview, day: day, image: image)
        } else {
            delegate?.error()
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        delegate?.cancelButtonClicked()
    }
}

extension CreateCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func selectDailyImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true

        delegate?.showPhotoLibrary(picker)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dailyImage.image = info[.originalImage] as? UIImage
        delegate?.closePhotoLibrary()
    }
}

