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
        
    }
    
    @IBAction func sendPhoto(sender: UIButton!) {
        
    }
    
    @IBAction func sendJSONData(sender: UIButton!) {
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        
    }
    
    
}

