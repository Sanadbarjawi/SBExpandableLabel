//
//  ExpandableLabel.swift
//  UHive
//
//  Created by Sanad Barjawi on 10/14/19.
//  Copyright (c) 2019 sanadbarjawi. All rights reserved.
//

import UIKit

private extension UILabel {
      var visibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        if let myText = self.text {
               
            let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
            let attributedText = NSAttributedString(string: myText, attributes: attributes as? [NSAttributedString.Key : Any])
            let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
            
            if boundingRect.size.height > labelHeight {
                var index: Int = 0
                var prev: Int = 0
                let characterSet = CharacterSet.whitespacesAndNewlines
                repeat {
                    prev = index
                    if mode == NSLineBreakMode.byCharWrapping {
                        index += 1
                    } else {
                        index = (myText as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: myText.count - index - 1)).location
                    }
                } while index != NSNotFound && index < myText.count && (myText as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
                return prev
            }
        }
        
        if self.text == nil {
            return 0
        } else {
            return self.text!.count
        }
    }
}

public protocol SBExpandableDelegate: NSObjectProtocol {
    func labelShouldCollpase()
    func labelShouldExpand()
}

public protocol Expandable: UILabel, SBExpandableDelegate {
    var isCollapsed: Bool {get set}
    var expandedText: String? {get set}
    var collapsedText: NSMutableAttributedString? {get set}
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor)
}
extension Expandable {
    public func labelShouldExpand() {}
    public func labelShouldCollpase() {}
}
extension Expandable {
    private func extractedFunc(_ trailingText: String, _ moreText: String, _ moreTextFont: UIFont, _ moreTextColor: UIColor) {
        let readMore = ReadMore(isCollapsed: isCollapsed, attributedText: attributedText, delegate: self, collapsedText: collapsedText, expandedText: expandedText)
        let readMoreText: String = trailingText + moreText
        expandedText = self.text
        if self.visibleTextLength == 0 { return }
        let lengthForVisibleString: Int = self.visibleTextLength
        
        if let myText = self.text {
            
            let mutableString: String = myText
            
            let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: myText.count - lengthForVisibleString), with: "")
            
            let readMoreLength: Int = (readMoreText.count)
            
            guard let safeTrimmedString = trimmedString else { return }
            
            if safeTrimmedString.count <= readMoreLength { return }
            
            let trimmedForReadMore: String = (safeTrimmedString as NSString).replacingCharacters(in: NSRange(location: safeTrimmedString.count - readMoreLength, length: readMoreLength), with: "") + trailingText
            
            let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 13)])
            let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
            answerAttributed.append(readMoreAttributed)
            self.attributedText = answerAttributed
            collapsedText = answerAttributed
            let gesture = UITapGestureRecognizer(target: self, action: #selector(readMore.configureReadMore))
            self.addGestureRecognizer(gesture)
            self.isUserInteractionEnabled = true
        }
    }
    
    public func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        extractedFunc(trailingText, moreText, moreTextFont, moreTextColor)
    }
}

private class ReadMore {
    var isCollapsed: Bool
    var attributedText: NSAttributedString?
    var collapsedText: NSMutableAttributedString?
    weak var delegate: SBExpandableDelegate?
    var expandedText: String?

    init(isCollapsed: Bool,
         attributedText: NSAttributedString?,
         delegate: SBExpandableDelegate?,
         collapsedText: NSMutableAttributedString?,
         expandedText: String?) {
        self.isCollapsed = isCollapsed
        self.attributedText = attributedText
        self.delegate = delegate
        self.collapsedText = collapsedText
        self.expandedText = expandedText
    }
    
     @objc func configureReadMore() {
        if isCollapsed {
         self.attributedText = NSAttributedString(string: expandedText ?? "")
            delegate?.labelShouldExpand()
        } else {
            delegate?.labelShouldCollpase()
            self.attributedText = collapsedText
        }
        isCollapsed.toggle()
    }
}

@IBDesignable
public class SBExpandableLabel: UILabel, Expandable {
    
    public var isCollapsed: Bool = true
    public weak var expandableDelegate: SBExpandableDelegate?
    public var expandedText: String?
    public var collapsedText: NSMutableAttributedString?
    
}

