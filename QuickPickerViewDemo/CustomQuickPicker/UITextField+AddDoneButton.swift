//
//  UITextField+AddDoneButton.swift
//  QuickPickerViewDemo
//
//  Created by Allen_Hsu on 2025/4/30.
//

import UIKit

typealias BlockAction = () -> Void

extension UITextField {

    // 設定 done button 的行為
    // inputView 是 UIPickerView 時, 會把 pickerview 的內容填回 textfield 裡面之後, 才縮下去
    // 一般的話是就直接縮下去
    func addToolBar(title:String="完成", color:UIColor = UIColor.black, isResign: Bool=true, isTranslucent: Bool=true, blockAction:BlockAction?) {
        let doneButton:UIBarButtonItem = UIBarButtonItem().initWithTitle(title: title, titleColor: color, style: .plain) { [weakSelf = self] in
            if self.inputView is UIPickerView {
                let pickerView:UIPickerView = weakSelf.inputView as! UIPickerView
                let selectedRow:Int = pickerView.selectedRow(inComponent: 0)
                pickerView.delegate?.pickerView!(pickerView, didSelectRow: selectedRow, inComponent: 0)
            }
            if isResign { weakSelf.resignFirstResponder()}
            
            if (blockAction != nil) {
                blockAction!()
            }
        }
        
        let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar:UIToolbar = UIToolbar.init()
        toolbar.items = [flexibleSpace, doneButton]
        self.inputAccessoryView = toolbar
        self.autocorrectionType = .no
        toolbar.isTranslucent = isTranslucent
        toolbar.setBackgroundImage(UIImage.init(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolbar.sizeToFit()
    }
}
