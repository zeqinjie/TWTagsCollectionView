//
//  TWTagsCollectionView.swift
//  house591
//
//  Created by zhengzeqin on 2019/8/29.
//  标签 View

import UIKit
import SnapKit

public class TWTagsCollectionView: UIView {
    // MARK: - LifeCycle
    /// 初始化
    /// - Parameters:
    ///   - frame: frame
    ///   - configure: 配置对象
    public init(
        frame: CGRect,
        configure: TWTagsCollectionViewConfigure
    ) {
        super.init(frame: frame)
        self.configure = configure
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.contentSizeObserver = nil
    }
    
    // MARK: - Public Method
    /// 代理
    @objc weak public var delegate: TWTagsCollectionViewDelegate? {
        didSet {
            guard let tagCollectionView = self.tagCollectionView else { return }
            guard let cellClass = delegate?.customCollectionViewCellClass?(self) else { return }
            tagCollectionView.register(cellClass, forCellWithReuseIdentifier: Marco.cellID)
        }
    }
    /// 监听 size 变化
    public var observerContentSizeBlock: ((_ size: CGSize) -> Void)?
    /// 数据源
    public var dataSource: [TWTagsCollectionCellModel]? {
        didSet {
            tagCollectionView?.reloadData()
        }
    }
    
    // 标签 collectionView
    public var tagCollectionView: UICollectionView?
    
    // MARK: - Private Method
    fileprivate struct Marco {
        static let cellID: String = "TWTagsCollectionViewCell"
    }
    /// Observation 注意 delloc 设置nil
    fileprivate var contentSizeObserver: NSKeyValueObservation?
    /// 内容高度
    fileprivate var contentSize: CGSize = .zero
    /// 配置对象
    fileprivate var configure: TWTagsCollectionViewConfigure?
    
    // MARK: - UI
    fileprivate func createUI() {
        guard let configure = self.configure else { return }
        var flowlayout: UICollectionViewFlowLayout?
        switch configure.alignedType {
        case .center:
            flowlayout = UICollectionViewCenterAlignedLayout()
        case .left:
            flowlayout = UICollectionViewLeftAlignedLayout()
        case .right:
            flowlayout = UICollectionViewRightAlignedLayout()
        default:
            flowlayout = UICollectionViewFlowLayout()
        }
        guard let layout = flowlayout else { return }
        layout.scrollDirection = configure.scrollDirection
        layout.minimumLineSpacing = configure.minimumLineSpacing
        layout.minimumInteritemSpacing = configure.minimumInteritemSpacing
        layout.sectionInset = configure.sectionInset
        self.tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let tagCollectionView = self.tagCollectionView else { return }
        tagCollectionView.backgroundColor = configure.backgroundColor
        tagCollectionView.isScrollEnabled = configure.isScrollEnabled
        tagCollectionView.register(TWTagsCollectionViewCell.self, forCellWithReuseIdentifier: Marco.cellID)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        self.addSubview(tagCollectionView)
        tagCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        switch configure.scrollDirection {
        case .vertical:
            tagCollectionView.showsVerticalScrollIndicator = configure.showsScrollIndicator
        case .horizontal:
            tagCollectionView.showsHorizontalScrollIndicator = configure.showsScrollIndicator
        default:
            break;
        }
        
        // 监听contentSize
        self.contentSizeObserver = tagCollectionView.observe(\UICollectionView.contentSize, options: [.new]) { [weak self] (_, change) in
            guard let size = change.newValue, let self = self else { return }
            if self.contentSize.height != size.height || self.contentSize.width != size.width {
                self.contentSize = size
                self.observerContentSizeBlock?(size)
            }
        }
    }
}

extension TWTagsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Marco.cellID, for: indexPath)
        let model = getModelIndex(indexPath: indexPath)
        self.delegate?.setupCustomCell?(cell, indexPath: indexPath, model: model, tagsCollectionView: self)
        if let model = model, let tagCell = cell as? TWTagsCollectionViewCell {
            tagCell.model = model
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let customSize = self.delegate?.tagsCollView?(self, layout: collectionViewLayout, sizeForItemAt: indexPath) {
            return customSize
        }
        var size = CGSize.zero
        let model = getModelIndex(indexPath: indexPath)
        if let model = model {
            size = CGSize(width: model.titleWidth, height: model.height)
        }
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return configure?.minimumLineSpacing ?? 4
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return configure?.minimumInteritemSpacing ?? 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.tagsCollView?(self, didSelectItemAt: indexPath)
    }
    
    // MARK: - Private Method
    fileprivate func getModelIndex(indexPath: IndexPath) -> TWTagsCollectionCellModel? {
        if let dataSource = dataSource {
            if dataSource.count > indexPath.row {
                return dataSource[indexPath.row]
            }
        }
        return nil
    }
    
}
