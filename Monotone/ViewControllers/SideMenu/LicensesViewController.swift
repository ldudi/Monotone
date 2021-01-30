//
//  LicensesViewController.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/29.
//

import UIKit
import WebKit

import SnapKit
import MJRefresh

import RxSwift
import RxRelay
import RxSwiftExt

// MARK: - LicensesViewController
class LicensesViewController: BaseViewController {
    
    // MARK: - Public

    
    // MARK: - Controls
    private var webView: WKWebView!
    private var agreementSelectionView: PageSelectionView!

    // MARK: - Priavte
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func buildSubviews() {
        
        self.view.backgroundColor = ColorPalette.colorWhite
        
        // AgreementSelectionView.
        self.agreementSelectionView = PageSelectionView()
        self.view.addSubview(self.agreementSelectionView)
        self.agreementSelectionView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view).multipliedBy(1.0/3)
            make.width.equalTo(88.0)
            make.centerY.equalTo(self.view).offset(10.0)
            make.right.equalTo(self.view).offset(-19.0)
        }
        
        // WebView.
        self.webView = WKWebView()
        self.webView.backgroundColor = UIColor.clear
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20.0)
            make.left.equalTo(self.view).offset(18.0)
            make.right.equalTo(self.agreementSelectionView.snp.left).offset(-20.0)
            make.bottom.equalTo(self.view)
        }
    }
    
    override func buildLogic() {
        
        // ViewModel.
        let licensesViewModel = self.viewModel(type: LicensesViewModel.self)!

        // Bindings.
        // Agreements.
        licensesViewModel.input.agreements
            .accept(UnsplashAgreement.allCases)
        
        // AgreementSelectionView.
        licensesViewModel.output.agreements
            .unwrap()
            .subscribe(onNext:{ [weak self] (aggrements) in
                guard let self = self else { return }
                
                self.agreementSelectionView.items.accept(aggrements.map({ return (key: $0, value: $0.rawValue.title) }))
            })
            .disposed(by: self.disposeBag)
        
        self.agreementSelectionView.selectedItem
            .unwrap()
            .subscribe(onNext:{ (item) in
                let agreement = item.key as! UnsplashAgreement
                licensesViewModel.input.selectedAgreement.accept(agreement)
            })
            .disposed(by: self.disposeBag)
            
        licensesViewModel.output.selectedAgreement
            .unwrap()
            .subscribe(onNext:{ [weak self] (agreement) in
                guard let self = self else { return }
                
                if let url = agreement.rawValue.content {
                    self.webView.load(URLRequest(url: url))
                }
                
            })
            .disposed(by: self.disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - WKNavigationDelegate
extension LicensesViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        // Forbid <a>.
        guard navigationAction.navigationType == .other || navigationAction.navigationType == .reload  else {
            decisionHandler(.cancel)
            return
        }
        
        webView.isHidden = true
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        // DarkMode.
        if(UITraitCollection.current.userInterfaceStyle == .dark){
            let cssString = "@media (prefers-color-scheme: dark) {body { background-color: black; color: white;} a:link {color: #0096e2;} a:visited {color: #9d57df;}}"
            let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
            webView.evaluateJavaScript(jsString, completionHandler: nil)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            webView.isHidden = false
        }
    }
}
