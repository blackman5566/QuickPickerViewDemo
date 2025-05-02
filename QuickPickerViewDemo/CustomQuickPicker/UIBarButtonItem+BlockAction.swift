//
//  UIBarButtonItem+BlockAction.swift
//  QuickPickerViewDemo
//
//  Created by Allen_Hsu on 2025/4/30.
//

import UIKit
fileprivate struct RuntimeKey {
    static var ActionBlockKey:UInt8 = 0
}

extension UIBarButtonItem {
    
    @objc func invokeBlockAction(){
        let blockAction:BlockAction? = self.blockAction()
        if (blockAction != nil){
            blockAction!()
        }
    }
    
    func initWithImage(image:UIImage,style:UIBarButtonItem.Style,blockAction:@escaping BlockAction) -> Self{
        self.setBlockAction(blockAction: blockAction)
        self.target = self
        self.image = image
        self.style = style
        self.action = #selector(invokeBlockAction)
        return self
    }
    
    func initWithTitle(title:String,titleColor:UIColor ,style:UIBarButtonItem.Style,blockAction:@escaping BlockAction) -> Self{
        self.setBlockAction(blockAction: blockAction)
        self.target = self
        self.title = title
        self.style = style
        self.action = #selector(invokeBlockAction)
        
        // 設定顏色
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: titleColor,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        self.setTitleTextAttributes(attributes, for: .normal)
        return self
    }
    
    
    //MARK: runtime objects
    func setBlockAction(blockAction:@escaping BlockAction){
        objc_setAssociatedObject(self, &RuntimeKey.ActionBlockKey, blockAction, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func blockAction() -> BlockAction?{
        return objc_getAssociatedObject(self, &RuntimeKey.ActionBlockKey) as? BlockAction
    }
}
