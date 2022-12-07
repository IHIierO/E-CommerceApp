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
        return imageScrollView
    }()
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(hexString: "#FDFAF3")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let vStack: UIStackView = {
       let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.alignment = .center
        vStack.spacing = UIStackView.spacingUseSystem
        vStack.backgroundColor = UIColor(hexString: "#FDFAF3")
        return vStack
    }()
    var productImages = [UIImage]()
    
    let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "#324B3A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let productPrice: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#324B3A")
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let addToCartButton = DefaultButton(buttonTitle: "Добавить в корзину")
    let descriptionHead: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(hexString: "#324B3A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let productDiscription: UITextView = {
       let label = UITextView()
        label.textContainerInset = .zero
       label.backgroundColor = UIColor(hexString: "#FDFAF3")
        label.textColor = UIColor(hexString: "#324B3A")
        label.font = UIFont.systemFont(ofSize: 18)
        label.isScrollEnabled = false
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        //pageControl.backgroundColor = .lightGray.withAlphaComponent(0.1)
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = UIColor(hexString: "#324B3A")
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    let recentlyViewedHead: UILabel = {
        let label = UILabel()
        label.text = "Вы недавно смотрели:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(hexString: "#324B3A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 30, bottom: 20, right: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.reuseId)
        collectionView.backgroundColor = UIColor(hexString: "#FDFAF3")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let blurEffect = UIBlurEffect(style: .regular)
    lazy var blurEffectView = UIVisualEffectView()
    
    var containerScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupProductCard()
        setConstraints()
        setupImageScrollView()
    }
    
    @objc func addToCartButtonTap(){
        ViewControllersHelper.addToCart(products: products, indexPath: indexPath, view: view, tabBarController: self.tabBarController!)
        addToCartButton.configuration?.title = !Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }) ? "Добавить в корзину" : "В корзине"
    }
    
    func setupNavigationBar(){
        BackButton(vc: self).createBackButton()
    }
    
    func setupProductCard(){
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        //let backButton = BackButton(vc: self)
       // backButton.addBackButton()
        view.addSubview(scrollView)
        scrollView.addSubview(vStack)
        [imageScrollView, productName, productPrice, addToCartButton, descriptionHead, productDiscription, recentlyViewedHead, collectionView].forEach {vStack.addArrangedSubview($0)}
        vStack.addSubview(pageControl)
        productDiscription.delegate = self
        textViewDidChange(productDiscription)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTap), for: .touchUpInside)
        addToCartButton.configuration?.title = !Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }) ? "Добавить в корзину" : "В корзине"
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setConstraints(){
        // constraint scrollView, vStack and pageControl
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            vStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            vStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            vStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            vStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            vStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor)
        ])
        // constraint imageScrollView
        imageScrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        imageScrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        // constraint products info
        [pageControl, productName, productPrice, addToCartButton, descriptionHead, productDiscription, recentlyViewedHead].forEach {
            NSLayoutConstraint.activate([
                $0.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -10),
                $0.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 10),
            ])
        }
        [productPrice, addToCartButton, descriptionHead, recentlyViewedHead].forEach {
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        // constraint collectionView
        collectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 1.6).isActive = true
    }
    
    func setupImageScrollView(){
        imageScrollView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height * 0.45)
        containerScrollView = UIScrollView(frame: UIScreen.main.bounds)
        containerScrollView.isPagingEnabled = true
       
        imageScrollView.delegate = self
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        for i in 0..<products[indexPath.row].productImage.count {
            
            let imageView = UIImageView()
            imageView.tag = i
            let fullScreenTap = UITapGestureRecognizer(target: self, action: #selector(fullScreenTap(_:)))
            fullScreenTap.view?.tag = i
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
        if products[indexPath.row].productImage.count == 1{
            pageControl.numberOfPages = 0
        }else{pageControl.numberOfPages = products[indexPath.row].productImage.count}
        
    }
    
    @objc func fullScreenTap(_ sender: UITapGestureRecognizer) {
        for i in 0..<products[indexPath.row].productImage.count{
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            tap.view?.tag = i
            let imageScrollView = ImageScrollView(image: UIImage(named: products[indexPath.row].productImage[i])!)
            imageScrollView.tag = i
            imageScrollView.frame = CGRect(x: containerScrollView.frame.width*CGFloat(i), y: 0, width: containerScrollView.frame.width, height: containerScrollView.frame.height)
            imageScrollView.contentMode = .scaleAspectFit
            imageScrollView.isUserInteractionEnabled = true
            tap.require(toFail: imageScrollView.zoomingTap)
            tap.delaysTouchesBegan = true
            imageScrollView.zoomingTap.delaysTouchesBegan = true
            imageScrollView.addGestureRecognizer(tap)
            
            containerScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(i + 1)
            containerScrollView.addSubview(imageScrollView)
        }
        //containerScrollView.addGestureRecognizer(tap)
        self.view.addSubview(blurEffectView)
        self.view.addSubview(containerScrollView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        containerScrollView.setContentOffset( CGPoint(x: containerScrollView.frame.size.width * CGFloat(sender.view!.tag), y: 0.0), animated: false)
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.blurEffectView.removeFromSuperview()
        self.containerScrollView.removeFromSuperview()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
      imageScrollView.setContentOffset( CGPoint(x: imageScrollView.frame.size.width * CGFloat(sender.view!.tag), y: 0.0), animated: true)
    }
    
    @objc func pageControlDidChange(_ sender: UIPageControl){
        let currentPage = sender.currentPage
        imageScrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * view.frame.size.width, y: 0), animated: true)
    }
}
//MARK: - UITextViewDelegate
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
//MARK: - UIScrollViewDelegate
extension ProductCard: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x)/Float(scrollView.frame.size.width)))
    }
}
//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension ProductCard: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Persons.ksenia.recentlyViewedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.reuseId, for: indexPath) as! ProductsCell
        cell.configure(with: indexPath.row, indexPath: indexPath, products: Persons.ksenia.recentlyViewedProducts.reversed())
        cell.addToShoppingCardCallback = { () in
            ViewControllersHelper.addToCart(products: Persons.ksenia.recentlyViewedProducts.reversed(), indexPath: indexPath, view: self.view, tabBarController: self.tabBarController!)
            collectionView.reloadData()
        }
        cell.favoriteButtonTapAction = {() in
            ViewControllersHelper.addToFavorite(products: Persons.ksenia.recentlyViewedProducts.reversed(), indexPath: indexPath)
            collectionView.reloadData()}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.size.width / 3, height: collectionView.frame.height / 1.2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Persons.ksenia.recentlyViewedProducts.reversed()[indexPath.row].id != products[self.indexPath.row].id {
            ViewControllersHelper.pushToProductCard(navigationController: navigationController, products: Persons.ksenia.recentlyViewedProducts.reversed(), indexPath: indexPath)
        }
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

