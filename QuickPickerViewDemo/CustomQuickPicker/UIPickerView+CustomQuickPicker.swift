//
//  UIPickerView+CustomQuickPicker.swift
//  QuickPickerViewDemo
//
//  Created by Allen_Hsu on 2025/4/30.
//

import UIKit

fileprivate struct RuntimeKey {
    static var title:UInt8 = 0
    static var attributedTitle:UInt8 = 1
    static var selected:UInt8 = 2
    static var components:UInt8 = 3
    static var rows:UInt8 = 4
    static var pickerType:UInt8 = 5
}

// closure 縮寫
typealias Title = (_ picker:UIPickerView,_ row:Int,_ component:Int) -> String
typealias AttributedTitle = (_ picker:UIPickerView,_ row:Int,_ component:Int) -> NSAttributedString
typealias Selected = (_ picker:UIPickerView,_ row:Int,_ component:Int ,_ selectedItem:String) -> Void
typealias Components = () -> Int
typealias Rows = (_ picker:UIPickerView,_ row:Int) -> Int

extension UIPickerView {
    func setTitle(customTitle:@escaping Title){
        objc_setAssociatedObject(self, &RuntimeKey.title, customTitle, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func title() -> Title {
        return objc_getAssociatedObject(self, &RuntimeKey.title) as! Title
    }
    
    func setAttributedTitle(attributedTitle:@escaping AttributedTitle){
        objc_setAssociatedObject(self, &RuntimeKey.attributedTitle, attributedTitle, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func attributedTitle() -> AttributedTitle{
        return objc_getAssociatedObject(self, &RuntimeKey.attributedTitle) as! AttributedTitle
    }
    
    func setSelected(selected:@escaping Selected){
        objc_setAssociatedObject(self, &RuntimeKey.selected, selected, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func selected() -> Selected{
        return objc_getAssociatedObject(self, &RuntimeKey.selected) as! Selected
    }
    
    func setComponents(components:@escaping Components){
        objc_setAssociatedObject(self, &RuntimeKey.components, components, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func components() -> Components{
        return objc_getAssociatedObject(self, &RuntimeKey.components) as! Components
    }
    
    func setRows(rows:@escaping Rows){
        objc_setAssociatedObject(self, &RuntimeKey.rows, rows, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func rows() -> Rows{
        return objc_getAssociatedObject(self, &RuntimeKey.rows) as! Rows
    }
    
    func setPickerType(pickerType:PickerType){
        objc_setAssociatedObject(self, &RuntimeKey.pickerType, pickerType, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func pickerType() -> PickerType {
        return objc_getAssociatedObject(self, &RuntimeKey.pickerType) as! PickerType
    }
}

