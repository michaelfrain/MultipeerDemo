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
    
    var startSend: NSDate!
    var endSend: NSDate!
    
    @IBOutlet var resourceProgress: UILabel!
    @IBOutlet var timeResult: UILabel!
    
    @IBOutlet var btnFilm: UIButton!
    @IBOutlet var btnPhoto: UIButton!
    @IBOutlet var btnJSON: UIButton!
    
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
        self.startSend = NSDate()
        let filePath = NSBundle.mainBundle().pathForResource("229-x6hu", ofType: "mp4")
        let video = NSData(contentsOfFile: filePath!)
        
        let error = NSErrorPointer()
        
        self.session.sendData(video, toPeers: self.session.connectedPeers, withMode: .Reliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
        
        
    }
    
    @IBAction func sendPhoto(sender: UIButton!) {
        self.startSend = NSDate()
        let filePath = NSBundle.mainBundle().pathForResource("BabyFacepalm", ofType: "JPG")
        let photo = NSData(contentsOfFile: filePath!)
        
        let error = NSErrorPointer()
        
        self.session.sendData(photo, toPeers: self.session.connectedPeers, withMode: .Reliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
    }
    
    @IBAction func sendJSONData(sender: UIButton!) {
        self.startSend = NSDate()
        let filePath = NSBundle.mainBundle().pathForResource("Twitter", ofType: "json")
        let json = NSData(contentsOfFile: filePath!)
        
        let error = NSErrorPointer()
        
        self.session.sendData(json, toPeers: self.session.connectedPeers, withMode: .Reliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        self.endSend = NSDate()
        self.resourceProgress.text = "Received Data from \(peerID.displayName)"
        let calendar = NSCalendar.currentCalendar()
        var components = calendar.components(NSCalendarUnit.CalendarUnitSecond, fromDate: self.startSend, toDate: self.endSend, options: NSCalendarOptions.MatchFirst)
        let timeToSend = components.second
        self.timeResult.text = "Time to send: \(timeToSend) seconds"
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        self.resourceProgress.text = "Receiving Resource from \(peerID.displayName): \(resourceName)"
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        self.resourceProgress.text = "Received Resource from \(peerID.displayName): \(resourceName)"
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        self.resourceProgress.text = "Received Input Stream from \(peerID.displayName)"
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        self.resourceProgress.text = "\(peerID.displayName) changed state to \(state.rawValue)"
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

