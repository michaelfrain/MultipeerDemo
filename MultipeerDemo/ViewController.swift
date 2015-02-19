//
//  ViewController.swift
//  MultipeerDemo
//
//  Created by Michael Frain on 2/18/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController , MCSessionDelegate, MCBrowserViewControllerDelegate {
    
    let serviceType = "GameDataSharing"
    
    var peerId: MCPeerID!
    var session: MCSession!
    var assistant: MCAdvertiserAssistant!
    var browser: MCBrowserViewController!
    
    @IBOutlet var resourceProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.peerId = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: self.peerId)
        self.session.delegate = self
        
        self.browser = MCBrowserViewController(serviceType: serviceType, session: self.session)
        
        self.browser.delegate = self
        
        self.assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: self.session)
        
        self.assistant.start()
    }

    @IBAction func showBrowser(sender: UIButton!) {
        self.presentViewController(self.browser, animated: true, completion: nil)
    }
    
    @IBAction func sendFilm(sender: UIButton!) {
        let video = NSData(contentsOfFile: "/MultipeerDemo/229-x6hu.mp4")
        
        let error = NSErrorPointer()
        
        self.session.sendData(video, toPeers: self.session.connectedPeers, withMode: .Reliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
        
        
    }
    
    @IBAction func sendPhoto(sender: UIButton!) {
        let photo = NSData(contentsOfFile: "BabyFacepalm.JPG")
        
        let error = NSErrorPointer()
        
        self.session.sendData(photo, toPeers: self.session.connectedPeers, withMode: .Reliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
    }
    
    @IBAction func sendJSONData(sender: UIButton!) {
        let json = NSData(contentsOfFile: "/Users/michaelfrain/MultipeerDemo/MultipeerDemo/Twitter.json")
        
        let error = NSErrorPointer()
        
        self.session.sendData(json, toPeers: self.session.connectedPeers, withMode: .Unreliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        if resourceName == "/Users/michaelfrain/MultipeerDemo/MultipeerDemo/229-x6hu.mp4" {
            self.resourceProgress.text = "Receiving film"
        }
        
        if resourceName == "BabyFacepalm.JPG" {
            self.resourceProgress.text = "Receiving photo"
        }
        
        if resourceName == "/Users/michaelfrain/MultipeerDemo/MultipeerDemo/Twitter.json" {
            self.resourceProgress.text = "Receiving JSON"
        }
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        if resourceName == "/Users/michaelfrain/MultipeerDemo/MultipeerDemo/229-x6hu.mp4" {
            self.resourceProgress.text = "Film received"
        }
        
        if resourceName == "BabyFacepalm.JPG" {
            self.resourceProgress.text = "Photo received"
        }
        
        if resourceName == "/Users/michaelfrain/MultipeerDemo/MultipeerDemo/Twitter.json" {
            self.resourceProgress.text = "JSON received"
        }
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

