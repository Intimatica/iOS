//
//  PickerView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/23/21.
//

import UIKit

final class PickerKeyboard: UIPickerView {
    // MARK: - Properties
    var data: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }
    
    var textFieldBeingEditing: UITextField?

    var selectedValue: String {
        get {
            guard let data = data else {
                return ""
            }
            
            return data[selectedRow(inComponent: 0)]
        }
    }
    
    override var inputAccessoryView: UIView? {
        let screenWidth = UIScreen.main.bounds.width
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: screenWidth, height: 44.0)))
        toolbar.translatesAutoresizingMaskIntoConstraints = false
//        toolbar.autoresizingMask = .flexibleHeight
        toolbar.barStyle = .default
        toolbar.tintColor = .systemBlue
        toolbar.backgroundColor = .clear
        toolbar.isTranslucent = false

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonDidTap))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidTap))

        toolbar.items = [cancelButton, flexSpace, doneButton]
        
        return toolbar
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancelButtonDidTap() {
//        genderView.textField.resignFirstResponder()
    }
    
    @objc func doneButtonDidTap() {
//        genderView.textField.resignFirstResponder()
//        print("selected: \(genderPicker.selectedValue)")
    }
}

// MARK: - UIPickerViewDataSource
extension  PickerKeyboard: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = data else {
            return 0
        }

        return data.count
    }
}

// MARK: - UIPickerViewDelegate
extension PickerKeyboard: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = data else {
            return ""
        }

        return data[row]
    }
}
