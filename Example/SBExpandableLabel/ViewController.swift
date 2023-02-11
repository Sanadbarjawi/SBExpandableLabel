//
//  ViewController.swift
//  SBExpandableLabel
//
//  Created by sanadbarjawi on 11/19/2019.
//  Copyright (c) 2019 sanadbarjawi. All rights reserved.
//

import UIKit
import SBExpandableLabel

class ViewController: UIViewController {
    @IBOutlet weak var testLabel : SBExpandableLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.expandableDelegate = self
        testLabel.addTrailing(with:
            """
            aklsjdfjklsadf jklasdfjk asdjklf asdjklf asjdklf asjkld fkj
            aklsjdfjklsadf jklasdfjk asdjklf asdjklf asjdklf asjkld fkjaklsjdfjklsadf jklasdfjk asdjklf asdjklf asjdklf asjkld fkjaklsjdfjklsadf jklasdfjk asdjklf asdjklf asjdklf asjkld fkjaklsjdfjklsadf jklasdfjk asdjklf asdjklf asjdklf asjkld fkjaklsjdfjklsadf jklasdfjk asdjklf asdjklf asjdklf asjkld fkjaklsjdfjklsadf jklasdfjk asdjklf asdjklf asjdklf asjkld fkj.
            """
            , moreText: "read more", moreTextFont: .systemFont(ofSize: 13), moreTextColor: .red)
    }

}
extension ViewController: SBExpandableDelegate {
    func labelShouldCollpase() {
        print("the label should collapse")
    }
    
    func labelShouldExpand() {
        print("the label should expand")
    }
    
}

