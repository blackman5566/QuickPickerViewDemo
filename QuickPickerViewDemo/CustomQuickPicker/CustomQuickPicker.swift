//
//  CustomQuickPicker.swift
//  QuickPickerViewDemo
//
//  Created by Allen_Hsu on 2025/4/30.
//

import UIKit

enum PickerType:Int {
    case PickerTypeTitle
    case PickerTypeAttributedTitle
}

//MARK: UIPickerViewDelegate
extension CustomQuickPicker:UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let titleString:String = (pickerView.delegate?.pickerView!(pickerView, titleForRow: row, forComponent: component))!
        pickerView.selected()(pickerView, row, component, titleString)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerType:PickerType = pickerView.pickerType()
        switch pickerType {
        case .PickerTypeTitle:
            let titleBlock:Title = pickerView.title()
            return titleBlock(pickerView, row, component)
        case .PickerTypeAttributedTitle:
            let attributedTitleBlock:AttributedTitle = pickerView.attributedTitle()
            return attributedTitleBlock(pickerView, row, component).string
        }
    }
}

//MARK: UIPickerViewDataSource
extension CustomQuickPicker:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        let componentsBlock:Components = pickerView.components()
        return componentsBlock()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let rowsBlock:Rows = pickerView.rows()
        return rowsBlock(pickerView,component)
    }
}

//MARK: life cycle
class CustomQuickPicker: UIPickerView {
    
    class func title(title:@escaping Title,components:@escaping Components,rows:@escaping Rows,selected:@escaping Selected) -> UIPickerView {
        let customQuickPicker = CustomQuickPicker()
        customQuickPicker.setTitle(customTitle: title)
        customQuickPicker.setPickerType(pickerType: .PickerTypeTitle)
        customQuickPicker.setSelected(selected: selected)
        customQuickPicker.setComponents(components: components)
        customQuickPicker.setRows(rows: rows)
        customQuickPicker.delegate = customQuickPicker
        customQuickPicker.dataSource = customQuickPicker
        return customQuickPicker
    }
    
    class func attributedTitle(attributedTitle:@escaping AttributedTitle, components:@escaping Components ,rows:@escaping Rows ,selected:@escaping Selected) -> UIPickerView{
        let customQuickPicker = CustomQuickPicker()
        customQuickPicker.setAttributedTitle(attributedTitle: attributedTitle)
        customQuickPicker.setPickerType(pickerType: .PickerTypeAttributedTitle)
        customQuickPicker.setSelected(selected: selected)
        customQuickPicker.setComponents(components: components)
        customQuickPicker.setRows(rows: rows)
        customQuickPicker.delegate = customQuickPicker
        customQuickPicker.dataSource = customQuickPicker
        return customQuickPicker
    }
}

