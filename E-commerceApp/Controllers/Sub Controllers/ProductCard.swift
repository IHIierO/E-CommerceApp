//
//  ProductCard.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class ProductCard: UIViewController {
    
    var products = [Product]()
    var indexPath = IndexPath()
    let imageScrollView: UIScrollView = {
        let imageScrollView = UIScrollView()
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.isPagingEnabled = true
        imageScrollView.showsHorizontalScrollIndicator = true
        imageScrollView.flashScrollIndicators()
        imageScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        return imageScrollView
    }()
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let vStack: UIStackView = {
       let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.alignment = .fill
        vStack.spacing = 2
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return vStack
    }()
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
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
        setConstraints()
        setupProductCard()
        setupImageScrollView()
        
    }
    
    @objc func addToCartButtonTap(){
        ViewControllersHelper.addToCart(products: products, indexPath: indexPath, view: view, tabBarController: self.tabBarController!)
        addToCartButton.configuration?.title = !Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }) ? "Добавить в корзину" : "В корзине"
    }
    
    func setupProductCard(){
        view.backgroundColor = .white
        productDiscription.delegate = self
        textViewDidChange(productDiscription)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTap), for: .touchUpInside)
        addToCartButton.configuration?.title = !Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }) ? "Добавить в корзину" : "В корзине"
    }
    func setupImageScrollView(){
        imageScrollView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height * 0.45)
        
        imageScrollView.delegate = self
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        for i in 0..<products[indexPath.row].productImage.count {
            let imageView = UIImageView()
            let fullScreenTap = UITapGestureRecognizer(target: self, action: #selector(fullScreenTap(_:)))
            productImages.append(UIImage(named: products[indexPath.row].productImage[i])!)
            imageView.image = productImages[i]
            imageView.frame = CGRect(x: view.frame.width*CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height * 0.45)
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(fullScreenTap)
            imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(i + 1)
            imageScrollView.addSubview(imageView)
            
        }
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        pageControl.numberOfPages = products[indexPath.row].productImage.count
    }
    
    private func setConstraints(){
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        scrollView.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            vStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            vStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            vStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            vStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [imageScrollView, pageControl, productName, productPrice, addToCartButton, descriptionHead, productDiscription].forEach {vStack.addArrangedSubview($0)}
        imageScrollView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.45).isActive = true
        productName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        productPrice.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        descriptionHead.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        imageScrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * view.frame.size.width, y: 0), animated: true)
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
            let vc = TabBar()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}

