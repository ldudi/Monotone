//
//  HelpViewModel.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/23.
//

import Foundation

import RxSwift
import RxRelay
import Action
import RxSwiftExt



class HelpViewModel: BaseViewModel, ViewModelStreamable{
    
    // MARK: - Input
    struct Input {
        var categories: BehaviorRelay<[UnsplashHelpCategory]?> = BehaviorRelay<[UnsplashHelpCategory]?>(value: nil)
    }
    public var input: Input = Input()
    
    // MARK: - Output
    struct Output {
        //
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
        //
    }
    
}
