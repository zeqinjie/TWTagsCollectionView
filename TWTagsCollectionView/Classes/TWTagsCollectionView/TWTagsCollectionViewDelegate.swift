//
//  TWTagsCollectionViewDelegate.swift
//  TWHouseUIKit_Swift
//
//  Created by zhengzeqin on 2021/6/10.
//

import Foundation

@objc public protocol TWTagsCollectionViewDelegate {
    /// 点击事件回调
    @objc optional func tagsCollView(_ tagsCollectionView: TWTagsCollectionView, didSelectItemAt indexPath: IndexPath)
    
    /// 自定义大小 size
    @objc optional func tagsCollView(_ tagsCollectionView: TWTagsCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    /* 自定义 cell 时候需要自己实现下面两个方法 */
    
    /// 自定义 cell
    @objc optional func customCollectionViewCellClass(_ tagsCollectionView: TWTagsCollectionView) -> AnyClass
    
    /// 设置 cell
    @objc optional func setupCustomCell(_ cell: UICollectionViewCell, indexPath: IndexPath, model: TWTagsCollectionCellModel?, tagsCollectionView: TWTagsCollectionView)
}
