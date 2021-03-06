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
    
    lazy var startSend = NSDate()
    var endSend: NSDate!
    var dataType = ""
    
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
        let newDate = self.startSend
        let filePath = NSBundle.mainBundle().pathForResource("229-x6hu", ofType: "mp4")
        let video = NSData(contentsOfFile: filePath!)
        
        let error = NSErrorPointer()
        
        self.session.sendData(video, toPeers: self.session.connectedPeers, withMode: .Reliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
        
        
    }
    
    @IBAction func sendPhoto(sender: UIButton!) {
        let newDate = self.startSend
        let filePath = NSBundle.mainBundle().pathForResource("BabyFacepalm", ofType: "JPG")
        let photo = NSData(contentsOfFile: filePath!)
        
        let error = NSErrorPointer()
        
        self.session.sendData(photo, toPeers: self.session.connectedPeers, withMode: .Reliable, error: error)
        
        if error != nil {
            NSLog(error.debugDescription)
        }
    }
    
    @IBAction func sendJSONData(sender: UIButton!) {
        let newDate = self.startSend
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
        if data.length > 4000000 && data.length < 5000000 {
            self.dataType = "Video"
        } else if data.length > 500000 && data.length < 3000000 {
            self.dataType = "Photo"
        } else {
            self.dataType = "JSON"
        }
        self.resourceProgress.text = "Received Data from \(peerID.displayName): \(self.dataType)"
        let calendar = NSCalendar.currentCalendar()
        var components = calendar.components(NSCalendarUnit.CalendarUnitSecond, fromDate: self.startSend, toDate: self.endSend, options: NSCalendarOptions.MatchFirst)
        let timeToSend = components.second
        self.timeResult.text = "Time to send: \(timeToSend) seconds"
        self.startSend = NSDate()
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
        var stateString = ""
        switch state {
        case MCSessionState.Connected:
            stateString = "Connected"
            
        case MCSessionState.Connecting:
            stateString = "Connecting"
            
        case MCSessionState.NotConnected:
            stateString = "Disconnected"
        }
        self.resourceProgress.text = "\(peerID.displayName) changed state to \(stateString)"
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

