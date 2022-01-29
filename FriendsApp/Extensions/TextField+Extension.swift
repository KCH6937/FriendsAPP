//
//  TextField+Extension.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/28.
//

import UIKit
import AnyFormatKit

extension UITextField {
    
    func getStringIndex(index: Int, text: String) -> String.Index {
        let outBoundsPrevent = 0
        if index == -1 {
            let i = text.index(text.startIndex, offsetBy: outBoundsPrevent)
            return i
        }
        
        let i = text.index(text.startIndex, offsetBy: index)
        return i
        
    }
    
    func formatPhoneNumber(range: NSRange, string: String) {
        guard let text = self.text else {
            return
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return
        }

        let newLength = text.count + string.count - range.length
        let formatter: DefaultTextInputFormatter
        let onlyPhoneNumber = text.filter { $0.isNumber }

        let currentText: String
        if newLength < 13 {
            if text.count == 13, string.isEmpty { // crash 방지
                formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
            } else {
                formatter = DefaultTextInputFormatter(textPattern: "###-###-####")
            }
        } else {
            formatter = DefaultTextInputFormatter(textPattern: "###-####-####")
        }

        currentText = formatter.format(onlyPhoneNumber) ?? ""
        let result = formatter.formatInput(currentText: currentText, range: range, replacementString: string)
        if text.count == 13, string.isEmpty {
            self.text = DefaultTextInputFormatter(textPattern: "###-###-####").format(result.formattedText.filter { $0.isNumber })
        } else {
            self.text = result.formattedText
        }

        let position: UITextPosition
        let startIndex = getStringIndex(index: result.caretBeginOffset - 1, text: self.text ?? "")
        let endIndex = getStringIndex(index: result.caretBeginOffset, text: self.text ?? "")
        if self.text?[startIndex ..< endIndex] == "-" {
            position = self.position(from: self.beginningOfDocument, offset: result.caretBeginOffset + 1)!
        } else {
            position = self.position(from: self.beginningOfDocument, offset: result.caretBeginOffset)!
        }

        self.selectedTextRange = self.textRange(from: position, to: position)
    }
    
}
