//
//  ViewController.swift
//  SwiftVoiceChage1
//
//  Created by Yuta Fujii on 2016/09/16.
//  Copyright © 2016年 Yuta Fujii. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {

    
    @IBOutlet var sv: UIScrollView!
    
    var uv = UIView()
    
    
    fileprivate var audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uv.frame = CGRect(x: 0, y: 0, width: 800, height: 80)
        
        for i in 0..<6{
        
            let button:UIButton = UIButton()
            button.tag = i
            button.frame = CGRect(x: (i*80) + 10, y: 0, width: 80, height: 80)
            let image:UIImage = UIImage(named: String(i + 1) + ".png")!
            button.setImage(image, for: UIControlState.normal)
            button.addTarget(self, action: #selector(changeVoice), for: .touchUpInside)
            
            uv.addSubview(button)
            uv.backgroundColor = UIColor.clear

            
        }
        
        
        sv.addSubview(uv)
        sv.contentSize = uv.bounds.size
        
        createVoice1()

        
    }
    
    
    func changeVoice(sender:UIButton){
    
        if(sender.tag == 0){
            
            audioEngine.stop()
            audioEngine.reset()
            createVoice1()
        
        }

        if(sender.tag == 1){
            
            audioEngine.stop()
            audioEngine.reset()
            createVoice2()
            
        }
        if(sender.tag == 2){
            
            audioEngine.stop()
            audioEngine.reset()
            createVoice3()
            
        }
        if(sender.tag == 3){
            
            audioEngine.stop()
            audioEngine.reset()
            createVoice4()
            
        }
        if(sender.tag == 4){
            
            audioEngine.stop()
            audioEngine.reset()
            createVoice5()
            
        }
        if(sender.tag == 5){
            
            audioEngine.stop()
            audioEngine.reset()
            createVoice6()
            
        }
    
    
    }
    
    func createVoice1(){
   
        
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // リバーブの設定
        let reverb = AVAudioUnitReverb()
        
        reverb.loadFactoryPreset(.largeHall2)
        
        audioEngine.attach(reverb)

        //声のゆがみ
        let distortion = AVAudioUnitDistortion()
        
        distortion.loadFactoryPreset(.multiDistortedSquared)
        
        distortion.preGain = -6
        
        audioEngine.attach(distortion)
        
        
        //イコライザーの設定
        let eq = AVAudioUnitEQ()
        eq.globalGain = 90
        audioEngine.attach(eq)
        

        //全てを順番に接続する
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        try! audioEngine.start()

        
    }
    
    
    func createVoice2(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.largeHall)
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiEcho1)
        distortion.preGain = -6
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 60
        audioEngine.attach(eq)
        
        //全てを順番に接続する
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()
        
        
        
    }

    func createVoice3(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.cathedral)
        reverb.wetDryMix = 50
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiBrokenSpeaker)
        distortion.preGain = -6
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 50
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()
        
        
    }

    func createVoice4(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.largeRoom2)
        audioEngine.attach(reverb)
        
        // Distortion
        
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiCellphoneConcert)
        distortion.preGain = -6
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 90
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()
        
        
    }

    func createVoice5(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.mediumChamber)
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiEcho2)
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 90
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()
        
        
    }

    func createVoice6(){
        
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.mediumHall3)
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.speechCosmicInterference)
        //    distortion.preGain = -10
        audioEngine.attach(distortion)
        
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = -96
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        //    audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        //audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()
        
        
        
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

