//
//  ViewController.swift
//  4Music
//
//  Created by Ivana Fidanovska on 4/14/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import CoreData


struct Item {
    var imageName: String
}

class ViewController: UIViewController {

    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var pauseImageView: UIImageView!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var radioNameLabel: UILabel!
    @IBOutlet var nowPlayingImageView: UIImageView!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var radioStationCollectionView: UICollectionView!
    @IBOutlet var favouriteButton: UIButton!
    
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    let audioSession = AVAudioSession.sharedInstance()
    let mediaView = MPVolumeView()
    
    let transition = SlideIn()
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!

    let cellIdentifier = "RadioCollectionCell"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
 //MARK: -Arrays
    
    var items:[Item] = [Item(imageName: "antenna5"),
                        Item(imageName: "106"),
                        Item(imageName: "bubamara"),
                        Item(imageName: "kanal77"),
                        Item(imageName: "metropolis"),
                        Item(imageName: "skyRadio")]
    
    var names = ["Antenna 5 FM", "Radio 106 Bitola", "Radio Bubamara", "Kanal 77", "Metropolis", "Sky Radio"]
    
    var radioUrlString = ["http://antenna5stream.neotel.mk:8000/live64", "http://stream.zemi.mk:8003/1", "http://stream.bubamara.com.mk/live-64.aac",
                    "http://kanal77.mk:8088/live.mp3", "https://eu4.fastcast4u.com/proxy/metradio?mp=/1", "https://s1.skyradio.com.mk/;*.mp3"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.isEnabled = false
        setupCollectionView()
        backgroundPlay()
        setupVolumeSlider()
        mediaView.isHidden = true
      //  getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setVolumeListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    //MARK: - CollectionView - RadioStation
    
    private func setupCollectionView() {
        radioStationCollectionView.delegate = self
        radioStationCollectionView.dataSource = self
        let nib = UINib(nibName: "RadioCollectionViewCell", bundle: nil)
        radioStationCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize() {
        if radioStationCollectionView == nil {
            let numberOfItemPerRow:CGFloat = CGFloat(items.count )
            let lineSpacing: CGFloat = 8
            
            let widht = (radioStationCollectionView.frame.width - (numberOfItemPerRow - 1))
            let hight = widht
            
            collectionViewFlowLayout.itemSize = CGSize(width: widht, height: hight)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            
            
            radioStationCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    //MARK: - Volume
    
    func setupVolumeSlider() {
       do {
        try audioSession.setActive(true)
       } catch {
        print("some error")
       }
        self.view.addSubview(mediaView)
        updateSlider()
    }
    
    func updateSlider(){
        volumeSlider.value = audioSession.outputVolume
    }
    
    func updateVolumeOnDevice(){
        MPVolumeView.setVolume(volumeSlider.value)
    }
    
    func setVolumeListener(){
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
      if keyPath == "outputVolume" {
        print("Volume = \(audioSession.outputVolume)")
        updateSlider()
      }
    }

    //MARK: - Play Radio
    
    func backgroundPlay(){
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.playback)
        }
        catch{
        }
    }
    
    func playRadio() {
        if player?.rate == 0 {
          //  self.view.showLoader(disableTouchEvents: true)
            player!.play()
          //  self.view.hideLoader()
            pauseImageView.image = UIImage(named: "stop")
            print ("play")
        }else{
            player!.pause()
            pauseImageView.image = UIImage(named: "play")
        }
    }
    
   
    //MARK: - Actions

    @IBAction func playButtonAction(_ sender: Any) {
       playRadio()
    }
    
    
    @IBAction func volumeSliderAction(_ sender: Any) {
        //player?.volume = volumeSlider.value
        updateVolumeOnDevice()
    }
    
    @IBAction func setiingsButtonAction(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "menuViewController") as? MenuTableViewController else {
            return
        }
        menuViewController.didTapMenuType = { menuType in
            print(menuType)
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        
        present(menuViewController, animated: true)

}
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        let model = MyList(context: context)
        model.radioName = radioNameLabel.text
        saveContext()
    
 }

    
    func transitionToNew(_ menuType: MenuType){
        
        switch menuType {
        case .favourites:
            performSegue(withIdentifier: "favourites", sender: nil)
        default:
            break
        }
    }
}

//MARK: -Extensions

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = radioStationCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RadioCollectionViewCell
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.borderWidth = 6
        cell.layer.cornerRadius = 15
        cell.layer.shadowRadius = 3
        
        cell.radioImageView.image = UIImage(named: items[indexPath.item].imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.radioNameLabel.text = names[indexPath.item]
        nowPlayingImageView.image = UIImage(named: items[indexPath.item].imageName)
        let radioStr = radioUrlString[indexPath.item]
        let radioUrl = URL(string: radioStr)
                playerItem = AVPlayerItem(url: radioUrl!)
                player = AVPlayer(playerItem: playerItem!)
               
                let playerLayer =  AVPlayerLayer(player: player!)
                playerLayer.frame = CGRect(x: -100, y: -100, width: 0, height: 0)
                self.view.layer.addSublayer(playerLayer)
    
        playButton.isEnabled = true
        
        print("didSelectItemAt: \(indexPath)")

     }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
   }



