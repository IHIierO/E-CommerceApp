//
//  BankCardFormatter.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 05.12.2022.
//

extension String {

    func containsOnlyDigits() -> Bool
    {

        let notDigits = NSCharacterSet.decimalDigits.inverted

        if rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
        {
            return true
        }

        return false
    }
}
import UIKit

var creditCardFormatter : CreditCardFormatter
{
    return CreditCardFormatter.sharedInstance
}

class CreditCardFormatter : NSObject
{
    static let sharedInstance : CreditCardFormatter = CreditCardFormatter()

    func formatToCreditCardNumber(isAmex: Bool, textField : UITextField, withPreviousTextContent previousTextContent : String?, andPreviousCursorPosition previousCursorSelection : UITextRange?) {
        var selectedRangeStart = textField.endOfDocument
        if textField.selectedTextRange?.start != nil {
            selectedRangeStart = (textField.selectedTextRange?.start)!
        }
        if  let textFieldText = textField.text
        {
            var targetCursorPosition : UInt = UInt(textField.offset(from:textField.beginningOfDocument, to: selectedRangeStart))
            let cardNumberWithoutSpaces : String = removeNonDigitsFromString(string: textFieldText, andPreserveCursorPosition: &targetCursorPosition)
            if cardNumberWithoutSpaces.count > 19
            {
                textField.text = previousTextContent
                textField.selectedTextRange = previousCursorSelection
                return
            }
            var cardNumberWithSpaces = ""
            if isAmex {
                cardNumberWithSpaces = insertSpacesInAmexFormat(string: cardNumberWithoutSpaces, andPreserveCursorPosition: &targetCursorPosition)
            }
            else
            {
                cardNumberWithSpaces = insertSpacesIntoEvery4DigitsIntoString(string: cardNumberWithoutSpaces, andPreserveCursorPosition: &targetCursorPosition)
            }
            textField.text = cardNumberWithSpaces
            if let finalCursorPosition = textField.position(from:textField.beginningOfDocument, offset: Int(targetCursorPosition))
            {
                textField.selectedTextRange = textField.textRange(from: finalCursorPosition, to: finalCursorPosition)
            }
        }
    }

    func removeNonDigitsFromString(string : String, andPreserveCursorPosition cursorPosition : inout UInt) -> String {
        var digitsOnlyString : String = ""
        for index in stride(from: 0, to: string.count, by: 1)
        {
            let charToAdd : Character = Array(string)[index]
            if isDigit(character: charToAdd)
            {
                digitsOnlyString.append(charToAdd)
            }
            else
            {
                if index < Int(cursorPosition)
                {
                    cursorPosition -= 1
                }
            }
        }
        return digitsOnlyString
    }

    private func isDigit(character : Character) -> Bool
    {
        return "\(character)".containsOnlyDigits()
    }

    func insertSpacesInAmexFormat(string : String, andPreserveCursorPosition cursorPosition : inout UInt) -> String {
        var stringWithAddedSpaces : String = ""
        for index in stride(from: 0, to: string.count, by: 1)
        {
            if index == 4
            {
                stringWithAddedSpaces += " "
                if index < Int(cursorPosition)
                {
                    cursorPosition += 1
                }
            }
            if index == 10 {
                stringWithAddedSpaces += " "
                if index < Int(cursorPosition)
                {
                    cursorPosition += 1
                }
            }
            if index < 15 {
               let characterToAdd : Character = Array(string)[index]
                stringWithAddedSpaces.append(characterToAdd)
            }
        }
        return stringWithAddedSpaces
    }


    func insertSpacesIntoEvery4DigitsIntoString(string : String, andPreserveCursorPosition cursorPosition : inout UInt) -> String {
        var stringWithAddedSpaces : String = ""
        for index in stride(from: 0, to: string.count, by: 1)
        {
            if index != 0 && index % 4 == 0 && index < 16
            {
                stringWithAddedSpaces += " "

                if index < Int(cursorPosition)
                {
                    cursorPosition += 1
                }
            }
            if index < 16 {
                let characterToAdd : Character = Array(string)[index]
                stringWithAddedSpaces.append(characterToAdd)
            }
        }
        return stringWithAddedSpaces
    }

}

