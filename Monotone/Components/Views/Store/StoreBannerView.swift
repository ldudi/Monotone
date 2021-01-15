//
//  StoreDetailsPropertyView.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit

import SnapKit
import HMSegmentedControl

import RxSwift
import RxCocoa
import RxSwiftExt

class StoreDetailsPropertyView: BaseView {
    
    // MARK: - Public
    public let storeItem: BehaviorRelay<StoreItem?> = BehaviorRelay<StoreItem?>(value: nil)
    public let selectedSize: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    public let quantity: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)

    // MARK: - Controls
    private var sizeLabel: UILabel!
    private var sizeStackView: UIStackView!
    private var sizeBtns: [UIButton] = [UIButton]()

    private var quantityLabel: UILabel!
    private var quantityTextField: UITextField!
    private var quantityPlusBtn: UIButton!
    private var quantityMinusBtn: UIButton!
    
    // MARK: - Private
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func buildSubviews() {
        super.buildSubviews()
        
        //
        
        
        // SizeLabel.
        self.sizeLabel = UILabel()
        self.sizeLabel.textColor = ColorPalette.colorGrayHeavy
        self.sizeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.sizeLabel.text = "Size"
        self.addSubview(self.sizeLabel)
        self.sizeLabel.snp.makeConstraints({ (make) in
            make.top.left.equalTo(self)
        })
        
        // SizeStackView.
        self.sizeStackView = UIStackView()
        self.sizeStackView.distribution = .equalSpacing
        self.sizeStackView.axis = .horizontal
        self.sizeStackView.spacing = 4.0
        self.addSubview(self.sizeStackView)
        self.sizeStackView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
        }
        
        // QuantityTextField.
        self.quantityTextField = UITextField()
        self.quantityTextField.keyboardType = .numberPad
        self.quantityTextField.textColor = ColorPalette.colorBlack
        self.quantityTextField.font = UIFont.boldSystemFont(ofSize: 12)
        self.quantityTextField.text = "Quantity"
        self.addSubview(self.quantityTextField)
        self.quantityTextField.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-26.0)
            make.bottom.equalTo(self)
            make.width.height.equalTo(40.0)
        })
        
        // QuantityLabel.
        self.quantityLabel = UILabel()
        self.quantityLabel.textColor = ColorPalette.colorGrayHeavy
        self.quantityLabel.font = UIFont.systemFont(ofSize: 12)
        self.quantityLabel.text = "Quantity"
        self.addSubview(self.quantityLabel)
        self.sizeLabel.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-7.0)
            make.left.equalTo(self)
        })
        
        // QuantityPlusBtn.
        self.quantityPlusBtn = UIButton()
        self.quantityPlusBtn.backgroundColor = ColorPalette.colorBlack
        self.quantityPlusBtn.setTitle("+", for: .normal)
        self.addSubview(self.quantityPlusBtn)
        self.quantityPlusBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.quantityTextField)
            make.left.equalTo(self.quantityTextField).offset(9.0)
            make.width.equalTo(17.0)
            make.height.equalTo(15.0)
        }
        
        // QuantityMiusBtn.
        self.quantityMinusBtn = UIButton()
        self.quantityMinusBtn.backgroundColor = ColorPalette.colorBlack
        self.quantityMinusBtn.setTitle("-", for: .normal)
        self.addSubview(self.quantityMinusBtn)
        self.quantityMinusBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.quantityTextField)
            make.left.equalTo(self.quantityTextField).offset(9.0)
            make.width.equalTo(17.0)
            make.height.equalTo(15.0)
        }

    }
    
    override func buildLogic() {
        super.buildLogic()
        
        // Bindings.
        // StoreItem.
        self.storeItem
            .unwrap()
            .subscribe(onNext: { [weak self] (item) in
                guard let self = self else { return }
                
                if let sizes = self.storeItem.value?.sizes {
                    self.layoutSizeBtns(sizes: sizes)
                }
                
            })
            .disposed(by: self.disposeBag)
        
        // Quantity
        self.quantityTextField.rx.text.orEmpty
            .map({ Int($0) })
            .unwrap()
            .bind(to: self.quantity)
            .disposed(by: self.disposeBag)
        
        // QualityPlusBtn.
        self.quantityPlusBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                
                if let quantityStr = self.quantityTextField.text{
                    self.quantityTextField.text = "\((Int(quantityStr) ?? 0) + 1)"
                }
            })
            .disposed(by: self.disposeBag)
        
        // QualityMinusBtn.
        self.quantityMinusBtn.rx.tap
            .subscribe(onNext:{ [weak self] (_) in
                guard let self = self else { return }
                
                if let quantityStr = self.quantityTextField.text{
                    self.quantityTextField.text = "\((Int(quantityStr) ?? 0) - 1)"
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func layoutSizeBtns(sizes:[String]){
        
        // Remove.
        for sizeBtn in self.sizeBtns{
            sizeBtn.removeFromSuperview()
        }
        self.sizeBtns.removeAll()
        
        // Add.
        sizes.enumerated().forEach { (index, element) in
            
            let sizeBtn = UIButton()
            sizeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            sizeBtn.layer.borderWidth = 1.0
            sizeBtn.layer.borderColor = ColorPalette.colorBlack.cgColor
            sizeBtn.layer.cornerRadius = 4.0
            sizeBtn.layer.masksToBounds = true
            sizeBtn.setTitle(element, for: .normal)
            sizeBtn.tag = index
            self.sizeStackView.addArrangedSubview(sizeBtn)
            sizeBtn.snp.makeConstraints { (make) in
                make.width.equalTo(40.0)
                make.height.equalTo(40.0)
            }
            
            sizeBtn.rx.tap
                .subscribe(onNext:{ [weak self] (_) in
                    guard let self = self else { return }
                    guard let sizes = self.storeItem.value?.sizes else { return }

                    self.sizeBtns.forEach { (element) in
                        element.isSelected = false
                        element.backgroundColor = UIColor.clear
                    }
                    
                    sizeBtn.isSelected = true
                    sizeBtn.backgroundColor = ColorPalette.colorBlack
                    
                    self.selectedSize.accept(sizes[sizeBtn.tag])
                })
                .disposed(by: self.disposeBag)
            
        }
        
    }
}
