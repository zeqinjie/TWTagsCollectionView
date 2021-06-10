//
//  TWTagsCollectionModel.swift
//  TWHouseUIKit_Swift
//
//  Created by zhengzeqin on 2021/6/9.
//

import UIKit

public struct TWTagsCollectionIconPosition {
    
    // MARK: - Public Property
    /// 图片高度
    public var height: CGFloat = 0
    /// 图片宽度
    public var width: CGFloat = 0
    /// 左边间隙
    public var left: CGFloat = 0
    /// 右边间隙
    public var right: CGFloat = 0
    /// 顶部间隙
    public var top: CGFloat = 0
    /// 默认 0
    public static let zero: TWTagsCollectionIconPosition = TWTagsCollectionIconPosition()
    
    // MARK: - Public Method
    public init(
        left: CGFloat = 0,
        right: CGFloat = 0,
        top: CGFloat = 0,
        width: CGFloat = 0,
        height: CGFloat = 0
    ) {
        self.height = height
        self.width = width
        self.left = left
        self.right = right
        self.top = top
    }
    
    /// 是相等
    public static func ==(lhs: TWTagsCollectionIconPosition, rhs: TWTagsCollectionIconPosition) -> Bool {
        return lhs.height == rhs.height
            && lhs.width == rhs.width
            && lhs.left == rhs.left
            && lhs.right == rhs.right
            && lhs.top == rhs.top
    }
    
    /// 不相等
    public static func !=(lhs: TWTagsCollectionIconPosition, rhs: TWTagsCollectionIconPosition) -> Bool {
        return !(lhs == rhs)
    }
    
}

open class TWTagsCollectionCellModel: NSObject {
    
    // MARK: - Public Property
    /// 剩余文本间隙
    public var gap: CGFloat = 4
    /// 文本背景色
    public var titleBgColor: UIColor = UIColor.white.withAlphaComponent(0.1) // TWColor_2478d2
    /// 文本颜色
    public var titleColor: UIColor =  UIColor.black // TWColor_2478d2!
    /// 文本对齐方式
    public var titleAlignment: NSTextAlignment = .center
    /// 文本字体
    public var font: UIFont = UIFont.systemFont(ofSize: 10)
    /// cell 高度
    public var height: CGFloat = 14
    /// 图片 icon
    public var icon: String = ""
    /// 图片位置
    public var iconPosition: TWTagsCollectionIconPosition = TWTagsCollectionIconPosition.zero
    /// cell 边框
    public var borderWidth: CGFloat = 0
    /// cell 边框颜色
    public var borderColor: UIColor?
    /// cell 边框弧度
    public var cornerRadius: CGFloat = 0
    /// 文本
    public var title: String = ""
    /// 文本宽度
    public var titleWidth: CGFloat = 0
    
    // MARK: - Public Method
    public override init() {}
    
    /// 📢 赋值 TWTagsCollModel 参数需求调用下
    public func updateTitle() {
        let titleW: CGFloat = self.width(str: title, height: height, font: font)
        titleWidth =
            iconPosition.width +
            iconPosition.left +
            iconPosition.right +
            gap +
            titleW
    }
    
    // MARK: - Private
    private func width(
        str: String,
        height: CGFloat,
        font: UIFont,
        lineBreakMode: NSLineBreakMode? = nil) -> CGFloat {
        var attrib: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }
        let size = CGSize(width: CGFloat(Double.greatestFiniteMagnitude) ,height: height)
        return ceil((str as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrib, context: nil).width)
    }
}
