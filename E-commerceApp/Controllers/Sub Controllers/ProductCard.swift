//
//  ProductCard.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class ProductCard: UIViewController {
    
    var scrollView = UIScrollView()
    var productImages = [UIImage]()
    
    let productName: UILabel = {
        let label = UILabel()
        label.text = "Cream"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let productPrice: UILabel = {
        let label = UILabel()
        label.text = "125"
        label.backgroundColor = .systemCyan
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.configuration = .gray()
        button.configuration?.title = "Добавить в корзину"
        button.configuration?.baseForegroundColor = .black
        button.configuration?.titleAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let descriptionHead: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.backgroundColor = .systemMint
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let productDiscription: UITextView = {
       let label = UITextView()
        label.backgroundColor = .systemMint
        label.text = "With calogen"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .lightGray.withAlphaComponent(0.1)
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let blurEffect = UIBlurEffect(style: .dark)
    lazy var blurEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        productDiscription.delegate = self
        textViewDidChange(productDiscription)
        setConstraints()
    }
    
    func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height * 0.45)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        for i in 0...2 {
            let imageView = UIImageView()
            let fullScreenTap = UITapGestureRecognizer(target: self, action: #selector(fullScreenTap(_:)))
            productImages.append(UIImage(named: "cream_for_hands_\(i + 1)")!)
            imageView.image = productImages[i]
            imageView.frame = CGRect(x: view.frame.width*CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height * 0.45)
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(fullScreenTap)
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
    }
    
    @objc func fullScreenTap(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let imageScrollView = ImageScrollView(image: imageView.image!)
        imageScrollView.frame = UIScreen.main.bounds
        imageScrollView.contentMode = .scaleAspectFit
        imageScrollView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        tap.require(toFail: imageScrollView.zoomingTap)
        tap.delaysTouchesBegan = true
        imageScrollView.zoomingTap.delaysTouchesBegan = true
        imageScrollView.addGestureRecognizer(tap)
        self.view.addSubview(blurEffectView)
        self.view.addSubview(imageScrollView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.blurEffectView.removeFromSuperview()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @objc func pageControlDidChange(_ sender: UIPageControl){
        let currentPage = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * view.frame.size.width, y: 0), animated: true)
    }

    private func setConstraints(){
        
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(productName)
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            productName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            productName.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            productName.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(productPrice)
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 0),
            productPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productPrice.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            productPrice.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(addToCartButton)
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 10),
            addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        view.addSubview(descriptionHead)
        NSLayoutConstraint.activate([
            descriptionHead.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: 10),
            descriptionHead.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionHead.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            descriptionHead.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(productDiscription)
        NSLayoutConstraint.activate([
            productDiscription.topAnchor.constraint(equalTo: descriptionHead.bottomAnchor, constant: 0),
            productDiscription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productDiscription.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            productDiscription.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }
}

extension ProductCard: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = productDiscription.sizeThatFits(size)
        productDiscription.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}

extension ProductCard: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x)/Float(scrollView.frame.size.width)))
    }
}

// MARK: - SwiftUI
import SwiftUI
struct ProductsCard_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let vc = ProductCard()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}

