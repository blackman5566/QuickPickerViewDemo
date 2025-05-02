# 🎯 CustomQuickPicker

為提升表單選擇元件的可重用性與開發效率，封裝 `UIPickerView` 並提供基於 closure 的介面，無需依賴傳統 delegate 實作即可完成選項綁定與事件回傳，使用上更直觀簡潔。

---

## 📦 使用範例

```swift
demoTextField.inputView = CustomQuickPicker.title(
    title: { [unowned self] (pickerView: UIPickerView, row: Int, component: Int) -> String in
        return self.items[row]
    },
    components: { () -> Int in
        return 1
    },
    rows: { [unowned self] (pickerView: UIPickerView, components: Int) -> Int in
        return self.items.count
    }) { [unowned self] (pickerView: UIPickerView, row: Int, component: Int, selectedItem: String) in
        self.demoTextField.text = selectedItem
        print("選擇字串 = \(selectedItem)")
    }

demoTextField.addToolBar(title: "完成", blockAction: nil)
```

---

✅ 特色：
- ✅ 不需實作 `UIPickerViewDelegate` / `UIPickerViewDataSource`
- ✅ 使用閉包處理資料來源與回傳
- ✅ 適合表單填寫、快速選項切換情境

---
