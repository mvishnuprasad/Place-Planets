//
//  ViewController.swift
//  Animation
//
//  Created by vishnu on 09/01/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var buttonBG: UILabel!
    @IBOutlet weak var Start: UIButton!
    @IBOutlet weak var Reset: UIButton!
    @IBOutlet weak var Reset2: UIButton!
    @IBOutlet weak var Reset3: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var snapShot: UIButton!
    var position = SCNVector3()
    var characters = [SCNNode]()
    let assets = ["rb1","rb2","rb3","rb4"]
    let textures = ["moon","neptune","mars","jupiter"]
    var planetSize = CGSize()
    var rect = CGRect()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCustomise()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showBoundingBoxes]
        
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            guard let query = sceneView.raycastQuery(from: touchLocation, allowing: .existingPlaneInfinite, alignment: .any)else { return}
            let results = sceneView.session.raycast(query)
         
            if let hitResults = results.first{
                self.position = SCNVector3(hitResults.worldTransform.columns.3.x, hitResults.worldTransform.columns.3.y + 0.025, hitResults.worldTransform.columns.3.z)
                self.rect = CGRect(x: CGFloat(position.x), y: CGFloat(position.y), width: 1.05, height: 2.50)
            }
        }
    }
    
    
    func showPlanet (number : Int) {
        if characters.count>1{
            for character in characters {
                character.removeFromParentNode()
            }
        }
        let Sphere = SCNSphere(radius: 0.025)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/\(textures[number]).jpeg")
        Sphere.materials = [material]
        let node = SCNNode()
        node.geometry = Sphere
        //node.position = SCNVector3(0, 0.05, -2 )
        node.position = self.position
        self.planetSize = CGSize(width: Double(node.scale.x), height: Double(node.scale.y))
        self.rect =  CGRect(x: CGFloat(position.x), y: CGFloat(position.y), width: CGFloat(node.boundingBox.max.x), height: CGFloat(node.boundingBox.max.y))
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
        characters.append(node)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAnchor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAnchor.planeExtent.width), height: CGFloat(planeAnchor.planeExtent.height))
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")!
            plane.materials = [gridMaterial]
            planeNode.geometry = plane
            node.addChildNode(planeNode)
            
        }else {
            return
        }
    }
}



extension ARSCNView {
    func snapshot( of area : CGRect,  afterScreenUpdates : Bool = true) -> UIImage {
        return UIGraphicsImageRenderer(bounds: area ).image { _ in
                     drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
                 }
    }
}
