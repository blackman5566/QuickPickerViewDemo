//
//  UIGestureRecognizer+BlockAction.swift
//  CosmedApp
//
//  Created by AllenShiu on 2017/4/13.
//  Copyright © 2017年 Ufispace. All rights reserved.
//

import UIKit

fileprivate struct RuntimeKey {
    static var ActionBlockKey:UInt8 = 0
}

extension UIGestureRecognizer {
    @objc func invokeBlockAction(){
        let blockAction:BlockAction? = self.blockAction()
        if (blockAction != nil){
            blockAction!()
        }
    }
    
    func initWithBlockAction(blockAction:@escaping BlockAction) -> Self {
        self.setBlockAction(blockAction: blockAction)
        self.addTarget(self, action: #selector(invokeBlockAction))
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
