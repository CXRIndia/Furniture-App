//
//  MainViewController.swift
//  FurnitureAR
//
//  Created by akshay patil on 14/02/20.
//  Copyright © 2020 akshay patil. All rights reserved.
//

import UIKit
import ARKit
import UIKit.UIGestureRecognizerSubclass
import TPKeyboardAvoiding
import ObjectMapper
import RealmSwift
import SwiftyGif
// MARK: - State

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

// MARK: - View Controller

class MainViewController: UIViewController {
    
    // MARK: - Constants
    
    @IBOutlet weak var tapInfoImageView: UIButton!
    @IBOutlet weak var tapInfoLabel: UILabel!
    @IBOutlet weak var tapToFindLocationTapViewBottom: NSLayoutConstraint!
    @IBOutlet weak var tapToFindLocationTapView: UIView!
    @IBOutlet weak var tapIconLabel: UILabel!
    @IBOutlet weak var tapIconBackGroundOverlayImage: UIImageView!
   // @IBOutlet weak var moveYourPhoneLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var arCoachingView: UIImageView!
    @IBOutlet weak var mobielPlaneImageView: UIImageView!
    private var popupOffset: CGFloat = 400
    private var bottomPopupOffset: CGFloat = 0
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var fixedBottomView: UIView!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var tapInfoImageViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var tapInfoImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tapInfoImageViewWidth: NSLayoutConstraint!
    var isAdded = true
    var isSelected = false
    var selectedNode: SCNNode?
    var currentAngleX: Float = 0.0
    var currentAngleY: Float = 0.0
    var currentAngleZ: Float = 0.0
    var lastNodeLocation = SCNVector3()
    var panStartZ: CGFloat = 0.0
    var selectedTabIndex = 0
    
    var couchesArray = Array<Couches>()
    var chairsArray = Array<Chairs>()
    var tablesArray = Array<Tables>()
    
    var planeArray = [SCNPlane]()
    var planeNodeArray = [SCNNode]()
    var itemToView: SavedItem?
    var arPlaneAnchors = [String:ARPlaneAnchor]()
    var easternMapleImageView = UIImageView()
    var images = [UIImage]()
    var snapshot: UIImage?
    var itemToViewArray = [SavedItem]()
    
    // MARK: - Views
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "content")
        return imageView
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
       // view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
     //   view.layer.shadowRadius = 10
        return view
    }()
    
    private lazy var closedTitleImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.image = UIImage(named: "homeIndicator")
       return imageView
    }()
    
    private lazy var openTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.heavy)
        label.textColor = .black
        label.textAlignment = .center
        label.alpha = 0
        label.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(translationX: 0, y: -15))
        return label
    }()
    
    private let scrollView  = TPKeyboardAvoidingScrollView()
    private (set) var contentView = UIView()
    let collectionView = UICollectionView(
        frame: CGRect.zero,
        collectionViewLayout: UICollectionViewFlowLayout.init()
    )
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let topViewForPan = UIView()
    let furnitureDetailView = FurnitureDetailView()
    let addDeleteFurnitureView = AddDeleteFurnitureView()
    var selectedArray = Array<String>()
    let titleLabel = UILabel()
    var lblBadge = UILabel()
    let imageView = UIImageView(image: UIImage(named: "grid_pattern")!)
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hideNavigationBar()
        
        for i in 0...83
        {
            images.append(UIImage(named: "Scanner\(i).png")!)
        }

        
        if let couchesArray = Mapper<Couches>().mapArray(JSONfile: "Couches.json") {
            self.couchesArray = couchesArray
        }
        if let tablesArray = Mapper<Tables>().mapArray(JSONfile: "Tables.json") {
            self.tablesArray = tablesArray
        }
        if let chairsArray = Mapper<Chairs>().mapArray(JSONfile: "Chairs.json") {
            self.chairsArray = chairsArray
        }
        
        
        setupARCoachingView()
        
        
        /*
        let gif = try! UIImage(gifName: "Scanning.gif")
        self.arCoachingView.setGifImage(gif, loopCount: -1) // Will loop forever
        self.arCoachingView.setCornerRadius(radius: 8)
        */
        
      //  moveYourPhoneLabel.isHidden = true
        cancelButton.isHidden = true
        checkMarkButton.isHidden = true
        arCoachingView.isHidden = true
        arCoachingView.stopAnimating()
        mobielPlaneImageView.isHidden = true
        tapIconLabel.isHidden = true
        tapIconBackGroundOverlayImage.isHidden = true
        popupOffset = self.view.frame.height - 190
        addTapGestureToSceneView()
        configureLighting()
        
        self.fixedBottomView.isHidden = true
        self.tapToFindLocationTapView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
        popupOffset = self.view.frame.height - (220 + self.view.safeAreaInsets.top)
        
        layout()
        setupCollectionView()
        setupEasternMapleImageView()
        setupTapToFindLocationTapView()
        topViewForPan.addGestureRecognizer(panRecognizer)
        self.view.bringSubviewToFront(self.fixedBottomView)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        setupButtonsImageandText()
        self.view.bringSubviewToFront(tapToFindLocationTapView)
        
        if self.view.safeAreaInsets.top > 0 {
            tapInfoImageViewBottom.constant = 24
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.animateEasternMapleImageView()
        }
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Layout
    
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    private var bottomConstraint = NSLayoutConstraint()
    private var heightConstraint = NSLayoutConstraint()
    
    private func layout() {
        
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.popupView.roundTop(radius: 40)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: popupOffset)
        bottomConstraint.isActive = true
        heightConstraint = popupView.heightAnchor.constraint(equalToConstant: self.view.frame.height - (self.view.safeAreaInsets.top + 220))
        heightConstraint.isActive = true
        
        closedTitleImageView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(closedTitleImageView)
        closedTitleImageView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor, constant: 0).isActive = true
        closedTitleImageView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 8).isActive = true
        closedTitleImageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        closedTitleImageView.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        
        setUpScrollView()
        setUpContentView()
        setupFurnitureDetailView()
        setupAddDeleteFurnitureView()
        
        self.popupView.addSubview(topViewForPan)
        topViewForPan.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topViewForPan.topAnchor.constraint(equalTo: popupView.topAnchor),
            topViewForPan.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            topViewForPan.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            topViewForPan.heightAnchor.constraint(equalToConstant: 39)
        ])
        topViewForPan.backgroundColor = .clear
        
    }
    
    
    private func setUpScrollView() {
        scrollView.bounces = false
        popupView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.constraintsEqualToSuperViewWithMargins()
        scrollView.isScrollEnabled = false
        
        if Display.typeIsLike == .iphone5 {
        scrollView.isScrollEnabled = true
        }
    }

    private func setUpContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.constraintsEqualToSuperView()
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(
                equalTo: popupView.widthAnchor
            ),
            contentView.heightAnchor.constraint(
                greaterThanOrEqualTo: scrollView.heightAnchor
            )
        ])
    }
    
    private func setupCollectionView() {
        collectionViewLayout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.setCollectionViewLayout(
            collectionViewLayout, animated: true
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(collectionView)
        NSLayoutConstraint.activate([
        collectionView.leadingAnchor.constraint(
            equalTo: popupView.leadingAnchor,
            constant: 8
        ),
        collectionView.trailingAnchor.constraint(
            equalTo: popupView.trailingAnchor,
            constant: -8
        ),
        collectionView.bottomAnchor.constraint(
            equalTo: popupView.bottomAnchor,
            constant: 0
        ),
        collectionView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 39)
        ]
        )
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier:
                   "ImageCollectionViewCell"
        )
        collectionView.register(WishListCollectionViewCell.self, forCellWithReuseIdentifier:
                   "WishListCollectionViewCell"
        )
        if UIDevice.isPad {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 600, right: 0)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        }
        
    }
    
    func setupFurnitureDetailView() {
        contentView.addSubview(furnitureDetailView)
        furnitureDetailView.delegate = self
        furnitureDetailView.isHidden = true
        furnitureDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        furnitureDetailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39),
        furnitureDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        furnitureDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        furnitureDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80),
        furnitureDetailView.heightAnchor.constraint(equalToConstant: 662)
        ])
    }
    
    func setupAddDeleteFurnitureView() {
        view.addSubview(addDeleteFurnitureView)
        addDeleteFurnitureView.isHidden = true
        addDeleteFurnitureView.delegate = self
        addDeleteFurnitureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        addDeleteFurnitureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        addDeleteFurnitureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        addDeleteFurnitureView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        addDeleteFurnitureView.heightAnchor.constraint(equalToConstant: 100)
        ])
        addDeleteFurnitureView.roundTop()
    }
    
    
   
    func setupEasternMapleImageView() {
        easternMapleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 216 , height: 216))
        easternMapleImageView.center = view.center
        easternMapleImageView.image = UIImage(named: "easternMaple")
        self.view.addSubview(easternMapleImageView)
        
        /*
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateEasternMapleImageView(_:)))
        easternMapleImageView.isUserInteractionEnabled = true
        easternMapleImageView.addGestureRecognizer(tap)
        */
    }
    
    func setupTapToFindLocationTapView() {
        tapToFindLocationTapView.roundBottom(radius: 40)
    }
    
    func setupARCoachingView() {
        arCoachingView.animationImages = images
        arCoachingView.animationDuration = 2.24
        arCoachingView.contentMode = .scaleAspectFill
    }
    
    @objc func animateEasternMapleImageView() {
        easternMapleImageView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
                    self.easternMapleImageView.alpha = 1
                    self.easternMapleImageView.center.x = 50
                    self.easternMapleImageView.center.y = (self.view.safeAreaInsets.top + 50)
                    self.easternMapleImageView.transform = CGAffineTransform(scaleX: 0.333, y: 0.333)
        }) { (_ ) in
            UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
                self.fixedBottomView.isHidden = false
                self.bottomViewHeightConstraint.constant = 80
                self.heightConstraint.constant = self.view.frame.height - (self.view.safeAreaInsets.top + 102)
                self.view.layoutIfNeeded()
                self.setupButtonsImageandText()
            }, completion: nil)
        }
    }
    
    @objc func moveBottomPopupToInitialHeight() {
        if self.bottomPopupOffset != 0 {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.bottomPopupOffset = 0
            if UIDevice.isPad {
            self.bottomConstraint.constant = 400
            } else {
            self.bottomConstraint.constant = self.bottomPopupOffset
            }
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        }
    }
    
    func hideBottomPopUpIfOpen() {
       
    }
    
    func openBottomPopUpIfNeeded() {
        animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
    }
    
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        
        if currentState == .open {
            selectedTabIndex = 0
            backButtonClicked()
            moveBottomPopupToInitialHeight()
        } else {
            selectedTabIndex = 0
            backButtonClicked()
            openBottomPopUpIfNeeded()
        }
        setupButtonsImageandText()
    }
    
    @IBAction func secondButtonClicked(_ sender: Any) {
       
       
        if currentState == .open {
          selectedTabIndex = 1
          backButtonClicked()
          moveBottomPopupToInitialHeight()
        } else {
           selectedTabIndex = 1
           backButtonClicked()
           openBottomPopUpIfNeeded()
        }
        setupButtonsImageandText()
    }
    
    @IBAction func thirdButtonClicked(_ sender: Any) {
      
       if currentState == .open {
         selectedTabIndex = 2
         backButtonClicked()
         moveBottomPopupToInitialHeight()
       } else {
          selectedTabIndex = 2
          
          backButtonClicked()
          openBottomPopUpIfNeeded()
       }
       setupButtonsImageandText()
    }
    
    @IBAction func fourthButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cartViewController = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        cartViewController.delegate = self
        cartViewController.modalPresentationStyle = .overFullScreen
        self.present(cartViewController, animated: true, completion: nil)
        
        /*
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self))
        tableView.reloadData()
       if currentState == .open {
         selectedTabIndex = 3
         backButtonClicked()
         moveBottomPopupToInitialHeight()
       } else {
         selectedTabIndex = 3
         backButtonClicked()
         openBottomPopUpIfNeeded()
       }
       tableView.isHidden = false
       setupButtonsImageandText()
       */
    }
    
    @IBAction func fifthButtonClicked(_ sender: Any) {
        // This code is for closing the bottom view if open
        if currentState != .closed {
          animateTransitionIfNeeded(to: .closed, duration: 1)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wishlistViewController = storyboard.instantiateViewController(withIdentifier: "WishlistViewController") as! WishlistViewController
        wishlistViewController.delegate = self
        wishlistViewController.modalPresentationStyle = .overFullScreen
        self.present(wishlistViewController, animated: true, completion: nil)
        
        // This code is for wishlist In the bottom view itself
        /*
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self))
        collectionView.reloadData()
        tableView.isHidden = true
        if currentState == .open {
          selectedTabIndex = 4
          backButtonClicked()
          moveBottomPopupToInitialHeight()
        } else {
           selectedTabIndex = 4
           
           backButtonClicked()
           openBottomPopUpIfNeeded()
        }
        setupButtonsImageandText()
        */
        
        // This is Old Code
        /*
        let realm = try! Realm()
        savedItemList = Array(realm.objects(SavedItem.self))
        tableView.reloadData()
       if currentState == .open {
         selectedTabIndex = 4
         backButtonClicked()
         moveBottomPopupToInitialHeight()
       } else {
         selectedTabIndex = 4
         backButtonClicked()
         openBottomPopUpIfNeeded()
       }
       tableView.isHidden = false
       setupButtonsImageandText()
       */
    }
    
    @objc func imageTapped() {

    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.cancelButton.isHidden = true
        self.arCoachingView.isHidden = true
        self.arCoachingView.stopAnimating()
      //  self.moveYourPhoneLabel.isHidden = true
        self.mobielPlaneImageView.isHidden = true
        self.isAdded = true
        self.popupView.isHidden = false
        self.fixedBottomView.isHidden = false
        hideTopViewWithAnimation()
    }
    
    @IBAction func checkMarkButtonClicked(_ sender: Any) {
        checkMarkButton.isHidden = true
       // self.tapIconLabel.isHidden = true
       // self.tapIconBackGroundOverlayImage.isHidden = true
        selectedNode?.setHighlighted(false, 1)
        selectedNode?.runAction(SCNAction.moveBy(x: 0, y: -0.05, z: 0, duration: 0.5), completionHandler: nil)
        selectedNode = nil
        isSelected = false
        self.addDeleteFurnitureView.isHidden = true
        self.hideTopViewWithAnimation()
        self.popupView.isHidden = false
        self.fixedBottomView.isHidden = false
        self.itemToView = nil
    }
    
    // MARK: - Animation
    
    /// The current state of the animation. This variable is changed only when an animation completes.
    private var currentState: State = .closed
    
    /// All of the currently running animators.
    private var runningAnimators = [UIViewPropertyAnimator]()
    
    /// The progress of each animator. This array is parallel to the `runningAnimators` array.
    private var animationProgress = [CGFloat]()
    
    private lazy var panRecognizer: InstantPanGestureRecognizer = {
        let recognizer = InstantPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()
    
  
    
    /// Animates the transition, if the animation is not already running.
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        
        // ensure that the animators array is empty (which implies new animations need to be created)
        guard runningAnimators.isEmpty else { return }
        
        // an animator for the transition
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                if self.furnitureDetailView.isHidden {
                    self.bottomPopupOffset = 0
                    print("Hidded")
                } else {
                    if self.view.safeAreaInsets.top > 0 {
                        self.bottomPopupOffset = 158
                    } else {
                        self.bottomPopupOffset = 0
                    }
                    print("not Hidded")
                }
                if UIDevice.isPad {
                self.bottomConstraint.constant = 400
                } else {
                self.bottomConstraint.constant = self.bottomPopupOffset
                }
              //  self.popupView.layer.cornerRadius = 30
                self.overlayView.alpha = 0.5
                self.openTitleLabel.transform = .identity
            case .closed:
                if self.furnitureDetailView.isHidden {
                    self.bottomPopupOffset = 0
                    print("Hidded")
                } else {
                    self.bottomPopupOffset = 158
                    print("not Hidded")
                }
                self.bottomConstraint.constant = self.popupOffset
             //   self.popupView.layer.cornerRadius = 20
                self.overlayView.alpha = 0
                
                self.openTitleLabel.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(translationX: 0, y: -15))
            }
            self.view.layoutIfNeeded()
        })
        
        // the transition completion block
        transitionAnimator.addCompletion { position in
            
            // update the state
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            @unknown default:
                print("default")
            }
            
            // manually reset the constraint positions
            switch self.currentState {
            case .open:
                if UIDevice.isPad {
                self.bottomConstraint.constant = 400
                } else {
                self.bottomConstraint.constant = self.bottomPopupOffset
                }
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
                self.backButtonClicked()
            }
            
            // remove all running animators
            self.runningAnimators.removeAll()
            
        }
        
        // an animator for the title that is transitioning into view
        let inTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: {
            switch state {
            case .open:
                self.openTitleLabel.alpha = 1
            case .closed:
               print("Close title image hide")
            }
        })
        inTitleAnimator.scrubsLinearly = false
        
        // an animator for the title that is transitioning out of view
        let outTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut, animations: {
            switch state {
            case .open:
                 print("Close title image show")
            case .closed:
                 self.openTitleLabel.alpha = 0
            }
        })
        outTitleAnimator.scrubsLinearly = false
        
        // start all animators
        transitionAnimator.startAnimation()
        inTitleAnimator.startAnimation()
        outTitleAnimator.startAnimation()
        
        // keep track of all running animators
        runningAnimators.append(transitionAnimator)
        runningAnimators.append(inTitleAnimator)
        runningAnimators.append(outTitleAnimator)
        
    }
    
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        if recognizer.name == "Tap_On_Tab_Bar" && currentState == .open {
            return
        }
        switch recognizer.state {
        case .began:
            
            // start the animations
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
            
            // pause all animations, since the next event may be a pan changed
            runningAnimators.forEach { $0.pauseAnimation() }
            
            // keep track of each animator's progress
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
        case .changed:
            
            // variable setup
            let translation = recognizer.translation(in: popupView)
            var fraction = -translation.y / popupOffset
            
            // adjust the fraction for the current state and reversed state
            if currentState == .open { fraction *= -1 }
            if runningAnimators[0].isReversed { fraction *= -1 }
            
            // apply the new fraction
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
            
        case .ended:
            
            // variable setup
            let yVelocity = recognizer.velocity(in: popupView).y
            let shouldClose = yVelocity > 0
            
            // if there is no motion, continue all animations and exit early
            if yVelocity == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
                break
            }
            
            // reverse the animations based on their current state and pan motion
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .closed:
                if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }
            
            // continue all animations
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
            
        default:
            ()
        }
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedTabIndex == 0 {
            return couchesArray.count
        } else if selectedTabIndex == 1 {
            return chairsArray.count
        } else if selectedTabIndex == 2 {
            return tablesArray.count
        } else if selectedTabIndex == 4 {
            return 0
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*
        if selectedTabIndex == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCollectionViewCell", for: indexPath) as! WishListCollectionViewCell
            cell.delegate = self
            cell.configureView(savedItem: savedItemList[indexPath.item])
            cell.backgroundColor = .white
            return cell
        } else  {
        */
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        if selectedTabIndex == 0 {
            if let imageName = couchesArray[indexPath.item].image, let furnitureName = couchesArray[indexPath.row].name {
                cell.configureView(imageName: imageName, furnitureName: furnitureName)
         }
        } else if selectedTabIndex == 1 {
         if let imageName = chairsArray[indexPath.item].image, let furnitureName = chairsArray[indexPath.row].name {
            cell.configureView(imageName: imageName, furnitureName: furnitureName)
         }
        } else {
         if let imageName = tablesArray[indexPath.item].image, let furnitureName = tablesArray[indexPath.row].name {
            cell.configureView(imageName: imageName, furnitureName: furnitureName)
         }
        }
        cell.backgroundColor = .white
        return cell
        // }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedTabIndex != 4 {
        scrollView.scrollToTop()
        if selectedTabIndex == 0 {
            let couch = couchesArray[indexPath.row]
            furnitureDetailView.configureView(for: couch)
        } else if selectedTabIndex == 1 {
            let chair = chairsArray[indexPath.row]
            furnitureDetailView.configureView(for: chair)
        } else {
            let table = tablesArray[indexPath.row]
            furnitureDetailView.configureView(for: table)
        }
        furnitureDetailView.isHidden = false
        collectionView.isHidden = true
            if self.view.safeAreaInsets.top > 0 {
                
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            
            if self.view.safeAreaInsets.top > 0 {
               self.bottomPopupOffset = 158
            } else {
               self.bottomPopupOffset = 0
            }
            self.bottomConstraint.constant = self.bottomPopupOffset
            self.view.layoutIfNeeded()
        }, completion: nil)
            
           }
        } else if selectedTabIndex == 4 {
            
        }
       /*
       arCoachingView.isHidden = false
       mobielPlaneImageView.isHidden = false
       isAdded = false
       animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
       */
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/2)-5, height: 164)
        /*
        if selectedTabIndex == 4 {
        return CGSize(width: (self.collectionView.frame.width/2)-5, height: 177)
        } else {
        return CGSize(width: (self.collectionView.frame.width/2)-5, height: 164)
        }
        */
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


extension MainViewController {
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.addShipToSceneView(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizerWithYAxis = PanDirectionGestureRecognizer(direction: .horizontal, target: self, action: #selector(MainViewController.rotateObjectWithYaxis(_:)))
        panGestureRecognizerWithYAxis.minimumNumberOfTouches = 2
        panGestureRecognizerWithYAxis.maximumNumberOfTouches = 2
        sceneView.addGestureRecognizer(panGestureRecognizerWithYAxis)
        
        let panGestureRecognizerWithXAxis = PanDirectionGestureRecognizer(direction: .horizontal, target: self, action: #selector(MainViewController.rotateObjectWithXaxis(_:)))
        panGestureRecognizerWithXAxis.minimumNumberOfTouches = 1
        panGestureRecognizerWithXAxis.maximumNumberOfTouches = 1
       
        sceneView.addGestureRecognizer(panGestureRecognizerWithXAxis)
        
        let panGestureRecognizerWithZAxis = PanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(MainViewController.rotateObjectWithZaxis(_:)))
        sceneView.addGestureRecognizer(panGestureRecognizerWithZAxis)
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration)
        sceneView.delegate = self
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    @objc func addShipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        if selectedNode == nil && addDeleteFurnitureView.isHidden == false {
            self.addDeleteFurnitureView.isHidden = true
            self.popupView.isHidden = false
            self.fixedBottomView.isHidden = false
        } else {
        let scnView = sceneView
        // check what nodes are tapped
        let p = recognizer.location(in: scnView)
        let hitResults = scnView!.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            var shipNode = result.node
            if !isSelected && shipNode.name != nil {
            // get its material
            for planeNode in planeNodeArray {
                if planeNode == shipNode {
                    self.sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in
                        if node.name == planeNode.name && node != planeNode {
                            shipNode = node
                        }
                    }
                }
            }
            currentAngleX = shipNode.worldPosition.x
            currentAngleZ = shipNode.worldPosition.z
            shipNode.runAction(SCNAction.moveBy(x: 0, y: 0.05, z: 0, duration: 0.5), completionHandler: nil)
            selectedNode = shipNode
            
            shipNode.setHighlighted()
            isSelected = true
            self.checkMarkButton.isHidden = false
            self.addDeleteFurnitureView.isHidden = false
                for item in itemToViewArray {
                    if selectedNode?.name == item.rootNode {
                        self.itemToView = item
                    }
                }
            if let itemToView = itemToView {
            self.addDeleteFurnitureView.configureView(savedItem: itemToView)
            }
            self.fixedBottomView.isHidden = true
            self.popupView.isHidden = true
            self.showTopViewWithAnimationForPan()
            }
           }
        }

    }
}

extension MainViewController {
    func showTopViewWithAnimationForTap() {
        tapInfoLabel.text = "Tap once you find the right location"
        tapInfoImageView.isHidden = false
        tapInfoImageViewWidth.constant = 40
        tapInfoImageViewHeight.constant = 40
        easternMapleImageView.hideWithAnimation(hidden: true)
        self.view.layoutIfNeeded()
        
        tapInfoImageView.setImage(UIImage(named: "TapFinger"), for: .normal)
        if self.tapToFindLocationTapView.isHidden == true {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.tapToFindLocationTapView.isHidden = false
            self.tapToFindLocationTapViewBottom.constant = -76
            self.view.layoutIfNeeded()
        }, completion: nil)
        }
    }
    
    func showTopViewWithAnimationForCoaching() {
        tapInfoLabel.text = "Move your iPhone left to right to start"
        tapInfoImageView.isHidden = true
        tapInfoImageViewWidth.constant = 0
        tapInfoImageViewHeight.constant = 40
        easternMapleImageView.hideWithAnimation(hidden: true)
        self.view.layoutIfNeeded()
        
        if self.tapToFindLocationTapView.isHidden == true {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.tapToFindLocationTapView.isHidden = false
            self.tapToFindLocationTapViewBottom.constant = -76
            self.view.layoutIfNeeded()
        }, completion: nil)
        }
    }
    
    func showTopViewWithAnimationForPan() {
        tapInfoLabel.text = "You can pan the product"
        tapInfoImageView.setImage(UIImage(named: "PanFinger"), for: .normal)
        tapInfoImageView.isHidden = false
        tapInfoImageViewWidth.constant = 40
        tapInfoImageViewHeight.constant = 40
        easternMapleImageView.hideWithAnimation(hidden: true)
        self.view.layoutIfNeeded()
        
        if self.tapToFindLocationTapView.isHidden == true {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.tapToFindLocationTapView.isHidden = false
            self.tapToFindLocationTapViewBottom.constant = -76
            self.view.layoutIfNeeded()
        }, completion: nil)
        }
    }
    
    
    
    func hideTopViewWithAnimation() {
        
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            if self.view.safeAreaInsets.top > 0 {
            self.tapToFindLocationTapViewBottom.constant = 44
            } else {
            self.tapToFindLocationTapViewBottom.constant = 0
            }
            self.view.layoutIfNeeded()
        }) { (_ ) in
            self.tapToFindLocationTapView.isHidden = true
            self.easternMapleImageView.hideWithAnimation(hidden: false)
        }
    }
}

extension MainViewController {
    
    @objc func rotateObjectWithXaxis(_ gesture: UIPanGestureRecognizer) {
           guard let nodeToRotate = selectedNode else { return }
           let name = nodeToRotate.name
        
           let translation = gesture.translation(in: gesture.view!)
           var newAngleX = (Float)(translation.x)*(Float)(Double.pi)/180.0
           let limitAngle = newAngleX + currentAngleX
           var lowerLimit: Float = -0.679
           var higherLimit: Float = 0.679
           if name == "M_177" || name == "_M_058" {
            lowerLimit = lowerLimit * 0.70
            higherLimit = higherLimit * 0.70
           }
          if limitAngle > lowerLimit && limitAngle < higherLimit {
           newAngleX += currentAngleX
           nodeToRotate.worldPosition.x = newAngleX
           
           for planeNode in planeNodeArray {
              if planeNode.name == name {
                planeNode.worldPosition.x = newAngleX
              }
            }
           if(gesture.state == .ended) { currentAngleX = newAngleX }
          } else {
            if(gesture.state == .ended) {gesture.setTranslation(.zero, in: gesture.view!)}
          }
           
    }
    
    @objc func rotateObjectWithYaxis(_ gesture: UIPanGestureRecognizer) {
        guard let nodeToRotate = selectedNode else { return }

        let translation = gesture.translation(in: gesture.view!)
        var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
        newAngleY += currentAngleY
        nodeToRotate.eulerAngles.y = newAngleY
        let name = nodeToRotate.name
        for planeNode in planeNodeArray {
           if planeNode.name == name {
             planeNode.eulerAngles.y = newAngleY
           }
         }
        if(gesture.state == .ended) { currentAngleY = newAngleY }
    }
    
    @objc func rotateObjectWithZaxis(_ gesture: UIPanGestureRecognizer) {
           guard let nodeToRotate = selectedNode else { return }
           let name = nodeToRotate.name
           let translation = gesture.translation(in: gesture.view!)
           var newAngleZ = (Float)(translation.y)*(Float)(Double.pi)/180.0
           let limitAngle = newAngleZ + currentAngleZ
           var lowerLimit: Float = -1.2
           var higherLimit: Float = 0.95
           if name == "M_177" || name == "_M_058" {
            lowerLimit = lowerLimit * 0.70
            higherLimit = higherLimit * 0.70
           }
        
           if limitAngle > lowerLimit && limitAngle < higherLimit {
           newAngleZ += currentAngleZ
           nodeToRotate.worldPosition.z = newAngleZ
           
           for planeNode in planeNodeArray {
             if planeNode.name == name {
               planeNode.worldPosition.z = newAngleZ
             }
           }
           if(gesture.state == .ended) {currentAngleZ = newAngleZ}
           } else {
            if(gesture.state == .ended) {gesture.setTranslation(.zero, in: gesture.view!)}
           }
    }
}


extension MainViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        if !isAdded {
        DispatchQueue.main.async {
            self.cancelButton.isHidden = true
          
            self.checkMarkButton.isHidden = false
            self.addDeleteFurnitureView.isHidden = false
            if let itemToView = self.itemToView {
            self.addDeleteFurnitureView.configureView(savedItem: itemToView)
            }
            self.arCoachingView.isHidden = true
            self.arCoachingView.stopAnimating()
       
            self.mobielPlaneImageView.isHidden = true
            self.showTopViewWithAnimationForTap()
        }
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        if let itemToView = self.itemToView, let nodeNameFromDB = itemToView.daeFileName {
             if nodeNameFromDB == "M_177.dae" || nodeNameFromDB == "M_058.dae" {
               let image = UIImage(named: "grid_pattern_circular")
               plane.materials.first?.diffuse.contents = image
             } else {
               let image = UIImage(named: "grid_pattern")
               plane.materials.first?.diffuse.contents = image
             }
        }
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
       
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,-0.002,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        var nodeName = "M_223.dae"
        var rootNodeName = "M_223"
            
        if let itemToView = self.itemToView, let nodeNameFromDB = itemToView.daeFileName, let rootNodeNameFromDB = itemToView.rootNode {
            nodeName = nodeNameFromDB
            rootNodeName = rootNodeNameFromDB
        }
        guard let shipScene = SCNScene(named: nodeName),
        let shipNode = shipScene.rootNode.childNode(withName: rootNodeName, recursively: false)
        else { return }
        shipNode.name = rootNodeName
        arPlaneAnchors[rootNodeName] = planeAnchor
        planeNode.name = rootNodeName
        shipNode.worldPosition = SCNVector3.positionFromTransform(planeAnchor.transform)
        planeNode.worldPosition = SCNVector3.positionFromTransform(planeAnchor.transform)
        guard let frame = self.sceneView.session.currentFrame else {
            return
        }
        currentAngleX = shipNode.worldPosition.x
        currentAngleZ = shipNode.worldPosition.z
        shipNode.eulerAngles.y = frame.camera.eulerAngles.y
        planeNode.eulerAngles.y = frame.camera.eulerAngles.y
            
            
        
        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path)  {
                let dict2 = dict as! [String : AnyObject]
                let technique = SCNTechnique(dictionary:dict2)

                // set the glow color to yellow
                let color = SCNVector3(1.0, 1.0, 1.0)
                technique?.setValue(NSValue(scnVector3: color), forKeyPath: "glowColorSymbol")

                self.sceneView.technique = technique
            }
        }
        
        selectedNode = shipNode
        sceneView.scene.rootNode.addChildNode(planeNode)
        sceneView.scene.rootNode.addChildNode(shipNode)
        selectedNode?.runAction(SCNAction.moveBy(x: 0, y: +0.05, z: 0, duration: 0), completionHandler: nil)
            
        let textContainerSize = shipNode.boundingBox
        let xSize = textContainerSize.max.x - textContainerSize.min.x
        let ySize = textContainerSize.max.y - textContainerSize.min.y
            
        if let itemToView = self.itemToView, let nodeNameFromDB = itemToView.daeFileName {
            if nodeNameFromDB == "M_177.dae" || nodeNameFromDB == "M_058.dae" {
            plane.width = CGFloat(ySize/100)
            plane.height = CGFloat(ySize/100)
            } else {
            plane.width = CGFloat(xSize/100)
            plane.height = CGFloat(ySize/100)
            }
        }

        planeArray.append(plane)
        planeNodeArray.append(planeNode)
        
        sceneView.debugOptions = []
        isAdded = true
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration, options: [ARSession.RunOptions.removeExistingAnchors, ARSession.RunOptions.resetTracking])
        sceneView.delegate = self
    }
}

extension MainViewController: FurnitureDetailViewDelegate {
    func backButtonClickedForFurniture() {
        backButtonClicked()
        if self.view.safeAreaInsets.top > 0 {
            
          UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.bottomPopupOffset = 0
            self.bottomConstraint.constant = self.bottomPopupOffset
            self.view.layoutIfNeeded()
          }, completion: nil)
            
        }
    }
    
    func backButtonClicked() {
        furnitureDetailView.isHidden = true
        collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
        collectionView.isHidden = false
        
        /*
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.bottomPopupOffset = 0
            self.bottomConstraint.constant = self.bottomPopupOffset
            self.view.layoutIfNeeded()
        }, completion: nil)
        */
    }
    
    func placeObjectButtonClicked(itemToView: SavedItem) {
        itemToViewArray.append(itemToView)
        self.itemToView = itemToView
        fixedBottomView.isHidden = true
        popupView.isHidden = true
        cancelButton.isHidden = false
        furnitureDetailView.isHidden = true
        collectionView.isHidden = false
        arCoachingView.isHidden = false
        arCoachingView.startAnimating()
        mobielPlaneImageView.isHidden = false
      //  moveYourPhoneLabel.isHidden = false
        isAdded = false
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
        showTopViewWithAnimationForCoaching()
        
    }
}

extension MainViewController: AddDeleteFurnitureViewDelegate {
    func addToWishListButtonClicked() {
      if let itemToView = itemToView {
        let realm = try! Realm()
        let savedItem = SavedItem(value: itemToView)
        if let item = realm.objects(SavedItem.self).filter("id == %@",itemToView.id!).first {
            if let index = itemToViewArray.firstIndex(of: itemToView) {
            itemToViewArray.remove(at: index)
            let itemToDelete = item
            
            try! realm.write {
                realm.delete(itemToDelete)
            }
            self.itemToView = savedItem
             itemToViewArray.insert(savedItem, at: index)
            }
            self.addDeleteFurnitureView.setAddToWishListImage()
        } else {
        try! realm.write {
            itemToView.itemCount = 1
            itemToView.itemInCart = false
            realm.add(itemToView, update: .all)
        }
        self.addDeleteFurnitureView.configureView(savedItem: itemToView)
        }
      }
    }
    
    func deleteButtonClicked() {
        for index in 0...itemToViewArray.count - 1 {
            if itemToViewArray[index] == itemToView {
                itemToViewArray.remove(at: index)
                self.itemToView = nil
                break;
            }
        }
        if let name = selectedNode?.name, let planeToRemove = arPlaneAnchors[name] {
        sceneView.session.remove(anchor: planeToRemove)
        arPlaneAnchors.removeValue(forKey: name)
       
        for planeNode in planeNodeArray {
           if planeNode.name == name {
            planeNode.removeFromParentNode()
            if let index = planeNodeArray.firstIndex(of: planeNode) {
              planeNodeArray.remove(at: index)
            }
            break;
            }
        }
        }
        
        selectedNode?.removeAllActions()
        selectedNode?.removeFromParentNode()
        selectedNode = nil
        
        checkMarkButton.isHidden = true
       // self.tapIconLabel.isHidden = true
       // self.tapIconBackGroundOverlayImage.isHidden = true
        self.addDeleteFurnitureView.isHidden = true
        self.hideTopViewWithAnimation()
        self.popupView.isHidden = false
        self.fixedBottomView.isHidden = false
    }
    
    func shutterButtonClicked() {
        checkMarkButton.isHidden = true
        selectedNode?.setHighlighted(false, 1)
        selectedNode?.runAction(SCNAction.moveBy(x: 0, y: -0.05, z: 0, duration: 0.5), completionHandler: nil)
        selectedNode = nil
        isSelected = false
        self.hideTopViewWithAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.78) {
            self.screenShotMethod()
        }
        self.itemToView = nil
    }
    
    func saveButtonClicked() {
        if let snapshot = snapshot {
        UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil);
        }
        self.addDeleteFurnitureView.isHidden = true
        self.popupView.isHidden = false
        self.fixedBottomView.isHidden = false
    }
    
    func shareButtonClicked() {
        if let snapshot = snapshot {
            UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil);
            let image = snapshot
            let imageToShare = [ image ]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            self.present(activityViewController, animated: true, completion: nil)
        }
        self.addDeleteFurnitureView.isHidden = true
        self.popupView.isHidden = false
        self.fixedBottomView.isHidden = false
    }
    
    func screenShotMethod() {
        //Create the UIImage
        /*
        selectedNode?.setHighlighted(false, 1)
        selectedNode?.runAction(SCNAction.moveBy(x: 0, y: -0.05, z: 0, duration: 0), completionHandler: nil)
        */
        snapshot = sceneView.snapshot()
        /*
        selectedNode?.runAction(SCNAction.moveBy(x: 0, y: 0.05, z: 0, duration: 0), completionHandler: nil)
        selectedNode?.setHighlighted()
        */
    }
}

extension MainViewController: WishListCollectionViewCellDelegate {
    
    func trashButtonClicked(savedItem: SavedItem) {
        /*
        let realm = try! Realm()
        try! realm.write {
            realm.delete(savedItem)
        }
        savedItemList = Array(realm.objects(SavedItem.self))
        collectionView.reloadData()
 
        */
    }
    
    func viewInArButtonClicked(savedItem: SavedItem) {
        fixedBottomView.isHidden = true
        popupView.isHidden = true
        cancelButton.isHidden = false
        furnitureDetailView.isHidden = true
        collectionView.isHidden = false
        arCoachingView.isHidden = false
        arCoachingView.startAnimating()
        mobielPlaneImageView.isHidden = false
        isAdded = false
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
        showTopViewWithAnimationForCoaching()
    }
}

extension MainViewController {
    func setupButtonsImageandText() {
        firstButton.setImage(UIImage(named: "Couches")?.withRenderingMode(.alwaysOriginal), for: .normal)
        firstButton.setTitle("Couches", for: .normal)
        firstButton.setTitleColor(.buttonTextColor, for: .normal)
        firstButton.tintColor = .buttonTextColor
        firstButton.alignImageAndTitleVerticallyForFirstButton()
        
        secondButton.setImage(UIImage(named: "Chairs")?.withRenderingMode(.alwaysOriginal), for: .normal)
        secondButton.setTitle("Chairs", for: .normal)
        secondButton.setTitleColor(.buttonTextColor, for: .normal)
        secondButton.tintColor = .buttonTextColor
        secondButton.alignImageAndTitleVertically()
        
        thirdButton.setImage(UIImage(named: "Tables")?.withRenderingMode(.alwaysOriginal), for: .normal)
        thirdButton.setTitle("Tables", for: .normal)
        thirdButton.setTitleColor(.buttonTextColor, for: .normal)
        thirdButton.tintColor = .buttonTextColor
        thirdButton.alignImageAndTitleVertically()
        
        fourthButton.setImage(UIImage(named: "ShoppingCart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        fourthButton.setTitle("Cart", for: .normal)
        fourthButton.setTitleColor(.buttonTextColor, for: .normal)
        fourthButton.tintColor = .buttonTextColor
        fourthButton.alignImageAndTitleVertically()
        
        fifthButton.setImage(UIImage(named: "Wishlist")?.withRenderingMode(.alwaysOriginal), for: .normal)
        fifthButton.setTitle("Wishlist", for: .normal)
        fifthButton.setTitleColor(.buttonTextColor, for: .normal)
        fifthButton.tintColor = .buttonTextColor
        fifthButton.alignImageAndTitleVertically()
        
        
        if selectedTabIndex == 0 {
            firstButton.setImage(UIImage(named: "CouchesSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
            firstButton.setTitle("Couches", for: .normal)
            firstButton.setTitleColor(.buttonTextColor, for: .normal)
            firstButton.alignImageAndTitleVerticallyForFirstButton()
        } else if selectedTabIndex == 1 {
            secondButton.setImage(UIImage(named: "ChairsSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
            secondButton.setTitle("Chairs", for: .normal)
            secondButton.setTitleColor(.buttonTextColor, for: .normal)
            secondButton.alignImageAndTitleVertically()
        } else if selectedTabIndex == 2 {
            thirdButton.setImage(UIImage(named: "TablesSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
            thirdButton.setTitle("Tables", for: .normal)
            thirdButton.setTitleColor(.buttonTextColor, for: .normal)
            thirdButton.alignImageAndTitleVertically()
        } else if selectedTabIndex == 3 {
            fourthButton.setImage(UIImage(named: "ShoppingCartSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
            fourthButton.setTitle("Cart", for: .normal)
            fourthButton.setTitleColor(.buttonTextColor, for: .normal)
            fourthButton.alignImageAndTitleVertically()
        } else if selectedTabIndex == 4 {
            fifthButton.setImage(UIImage(named: "WishlistSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
            fifthButton.setTitle("Wishlist", for: .normal)
            fifthButton.setTitleColor(.buttonTextColor, for: .normal)
            fifthButton.alignImageAndTitleVertically()
        }
        setBadge()
    }
}

extension MainViewController:WishlistViewControllerDelegate {
    func diddismissVC() {
        setBadge()
    }
    func didRemoveItem(savedItem: SavedItem) {
    
        if let index = itemToViewArray.firstIndex(of: savedItem) {
            let removedItemCopy = SavedItem(value: savedItem)
            if self.itemToView != nil && itemToView?.name == savedItem.name {
                self.itemToView = removedItemCopy
            }
            itemToViewArray.remove(at: index)
            itemToViewArray.insert(removedItemCopy, at: index)
        }
        
       

        let realm = try! Realm()
        try! realm.write {
            realm.delete(savedItem)
        }
    }
    
    func didUpdateWishListItemToCart() {
        
    }
    
    func diddismissVC(index: Int) {
        if index == 0 {
            firstButtonClicked(self)
        } else if index == 1 {
            secondButtonClicked(self)
        } else if index == 2 {
            thirdButtonClicked(self)
        } else if index == 3 {
            fourthButtonClicked(self)
        } else if index == 4 {
            fifthButtonClicked(self)
        }
    }

}

extension MainViewController {
    @objc func setBadge() {
        let realm = try! Realm()
        let savedItemList = Array(realm.objects(SavedItem.self).filter("itemInCart = true"))
        if savedItemList.count > 0 {
        lblBadge.frame = CGRect.init(x: fourthButton.frame.width/2, y: -10, width: 24, height: 24)
        lblBadge.backgroundColor = .white
        lblBadge.layer.borderColor = UIColor.buttonTextColor.cgColor
        lblBadge.layer.borderWidth = 1
        lblBadge.setCornerRadius(radius: 12)
        lblBadge.textColor = UIColor.buttonTextColor
        lblBadge.font = .regular(14)
        lblBadge.textAlignment = .center
        lblBadge.isHidden = false
        lblBadge.text = "\(savedItemList.count)"
        lblBadge.removeFromSuperview()
        fourthButton.addSubview(lblBadge)
        } else {
        lblBadge.text = ""
        lblBadge.isHidden = true
        lblBadge.removeFromSuperview()
        }
    }
}
