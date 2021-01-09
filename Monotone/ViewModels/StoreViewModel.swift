//
//  StoreViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/9.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt

class StoreViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var categories: BehaviorRelay<[StoreCategory]?> = BehaviorRelay<[StoreCategory]?>(value: nil)
        var selectedCategory: BehaviorRelay<StoreCategory?> = BehaviorRelay<StoreCategory?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        var categories: BehaviorRelay<[StoreCategory]?> = BehaviorRelay<[StoreCategory]?>(value: nil)
        var selectedCategory: BehaviorRelay<StoreCategory?> = BehaviorRelay<StoreCategory?>(value: nil)
        
        var storeItems: BehaviorRelay<[StoreItem]?> = BehaviorRelay<[StoreItem]?>(value: nil)
    }
    public var output: Output = Output()
    
    // MARK: - Private
    //
    
    // MARK: - Inject
    override func inject(args: [String : Any?]?) {
        //
    }
    
    // MARK: - Bind
    override func bind() {
        
        // Service.
        //
        
        // Bindings.
        self.input.categories
            .bind(to: self.output.categories)
            .disposed(by: self.disposeBag)
        
        self.input.selectedCategory
            .bind(to: self.output.selectedCategory)
            .disposed(by: self.disposeBag)
        
        self.input.selectedCategory
            .unwrap()
            .subscribe(onNext:{ [weak self] (category) in
                guard let self = self else { return }
                
                self.output.storeItems.accept(category.rawValue.items)
            })
            .disposed(by: self.disposeBag)
    }
    
}
