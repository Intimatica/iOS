//
//  UITextField+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector, minimumDate: Date?, maximumDate: Date?) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        
        if let minimumDate = minimumDate {
            datePicker.minimumDate = minimumDate
        }
        
        if let maximumDate = maximumDate {
            datePicker.maximumDate = maximumDate
        }
        
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
          datePicker.preferredDatePickerStyle = .wheels
          datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: L10n("CANCEL"), style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: L10n("DONE"), style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
