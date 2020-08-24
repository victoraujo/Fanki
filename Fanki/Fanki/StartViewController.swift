//
//  StartViewController.swift
//  Fanki
//
//  Created by Victor Vieira on 20/08/20.
//  Copyright © 2020 Victor Vieira. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    
    @IBOutlet public var wordText: UILabel!
    @IBOutlet public var transText: UILabel!
    @IBOutlet var easyButton: UIButton!
    @IBOutlet var dontButton: UIButton!
    var text:String!
    var trans: String!
    public var models = [MyWords]()
    public var completion: (([MyWords]) -> Void)?
    public var condc: Bool!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        wordText.text = "Será?"
        text = models[0].title
        trans = models[0].indentifier
        setWord()
        transText.isHidden = true
        easyButton.isEnabled = true
        dontButton.isEnabled = true
        
    }
    
    func viewWillDisappear() {
        condc = false
        completion?(models)
        
    }
    
    
    
    public func setText(_ word: String,_ trans: String){
        text = word
        self.trans = trans
//        print(word)
//        print(wordText?.text)
    }
    func setWord(){
        wordText.text = text
        transText.text = trans
    //        print(word)
    //        print(wordText?.text)
        }
    func setModel(_ model:[MyWords]){
        models = model
    }
   
    @IBAction func didTapEasy(){
        removeFirst()
    }
    
    @IBAction func didTapHard(){
        removeFirst()
    }
    
    @IBAction func didTapDont(){
        transText.isHidden = false
        easyButton.isEnabled = false
        dontButton.isEnabled = false
    }
    
    func removeFirst(){
        
        models.removeFirst(1)
        if models.count > 0{
            text = models[0].title
            trans = models[0].indentifier
            setWord()
            easyButton.isEnabled = true
            dontButton.isEnabled = true
        }
        else{
            dismiss(animated: true, completion: nil)
            //navigationController?.popViewController(animated: true)
            
        }
        transText.isHidden = true

    }
    
}
