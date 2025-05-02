//
//  ViewController.swift
//  QuickPickerViewDemo
//
//  Created by Allen_Hsu on 2025/4/30.
//

import UIKit

//MARK: setup
extension ViewController {
    //宣告 QuickPicker
    func setupCustomQuickPicker() {
        demoTextField.inputView = CustomQuickPicker.title(title: { [unowned self] (pickerView:UIPickerView, row:Int, component:Int) -> String in
            return self.items[row]
        }, components: { () -> Int in
            return 1
        }, rows: { [unowned self] (pickerView:UIPickerView, components:Int) -> Int in
            return self.items.count
        }) { [unowned self] (pickerView:UIPickerView, row:Int, component:Int, selectedItem:String) in
            self.demoTextField.text = selectedItem
            print("選擇字串 = \(selectedItem)")
        }
        
        demoTextField.addToolBar(title: "完成", blockAction: nil)
    }
    
    
}

//MAEK: life cycle
class ViewController: UIViewController {
    @IBOutlet weak var demoTextField: UITextField!
    let items = ["選擇資料1","選擇資料2","選擇資料3","選擇資料4","選擇資料5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomQuickPicker()
    }
}

