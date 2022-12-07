//
//  LaunchScreen.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 01.12.2022.
//

import UIKit

class LaunchScreen: UIViewController {
    
    let label: UILabel = {
       let label = UILabel()
        label.text = """
        Данное приложение создано исключительно в обучающих целях.
        
        Приведенные в нем товары не используются для получения комерческий прибыли.
        """
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(hexString: "#324B3A")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goToAppButton = DefaultButton(buttonTitle: "К приложению")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        setConstraints()
        goToAppButton.addTarget(self, action: #selector(goToAppButtonAction), for: .touchUpInside)
    }
    
    @objc func goToAppButtonAction(){
        let tabBAr = TabBar()
        tabBAr.modalTransitionStyle = .crossDissolve
        tabBAr.modalPresentationStyle = .fullScreen
        self.present(tabBAr, animated: true)
    }
    
    private func setConstraints(){
        view.addSubview(label)
        view.addSubview(goToAppButton)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            goToAppButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            goToAppButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            goToAppButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            goToAppButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI
struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = LaunchScreen()
            return vc
        }.edgesIgnoringSafeArea(.all)
            
    }
}
