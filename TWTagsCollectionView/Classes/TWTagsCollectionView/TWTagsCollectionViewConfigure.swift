//
//  TWTagsCollectionViewConfigure.swift
//  TWHouseUIKit_Swift
//
//  Created by zhengzeqin on 2021/6/9.
//  配置对象

import UIKit

public enum TWTagsCollectionViewAlignedType {
    case  `default`
    case  left
    case  center
    case  right
}

public class TWTagsCollectionViewConfigure {
    /// 最小行间隙
    public var minimumLineSpacing: CGFloat = 4
    /// 最小cell间隙
    public var minimumInteritemSpacing: CGFloat = 4
    /// 对齐方式, 默认系统的
    public var alignedType: TWTagsCollectionViewAlignedType = .default
    /// 滚动方向 默认水平
    public var scrollDirection: UICollectionView.ScrollDirection = .vertical
    /// 设置间隙
    public var sectionInset: UIEdgeInsets = .zero
    /// 背景颜色
    public var backgroundColor: UIColor = .clear
    /// 是否支持滚动
    public var isScrollEnabled: Bool = true
    /// 是否显示滑动条
    public var showsScrollIndicator: Bool = true
    
    public init() {}
}
