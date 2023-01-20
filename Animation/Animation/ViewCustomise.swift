//
//  VC Buttons.swift
//  Animation
//
//  Created by vishnu on 12/01/23.
//

import UIKit
import SceneKit
import ARKit


extension ViewController {
    @IBAction func showFirstChara(_ sender: Any) {
        // showChara(number: 0)
        showPlanet(number: 0)
    }
    @IBAction func showSecondChara(_ sender: Any) {
        //   showChara(number: 1)
        showPlanet(number: 1)
    }
    @IBAction func ahowThirdChara(_ sender: Any) {
        //showChara(number: 2)
        showPlanet(number: 2)
    }
    @IBAction func showFourthChara(_ sender: Any) {
        //showChara(number: 3)
        showPlanet(number: 3)
    }
    
    @IBAction func showHide(_ sender: Any) {
        buttonBG.isHidden.toggle()
        stackView.isHidden.toggle()
        snapShot.isHidden.toggle()
    }
    @IBAction func snapShot(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = sceneView.snapshot(of: rect)
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func viewCustomise () {
        Start.layer.cornerRadius = 25
        Reset.layer.cornerRadius = 25
        Reset2.layer.cornerRadius = 25
        Reset3.layer.cornerRadius = 25
        buttonBG.layer.masksToBounds = true
        buttonBG.layer.cornerRadius = 40
        sceneView.delegate = self
        sceneView.showsStatistics = true
        buttonBG.isHidden = true
        stackView.isHidden = true
        snapShot.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
}
