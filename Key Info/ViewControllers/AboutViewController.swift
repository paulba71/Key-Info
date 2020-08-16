//
//  AboutViewController.swift
//  Key Info
//
//  Created by Paul Barnes on 13/07/2020.
//  Copyright © 2020 Paul Barnes. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool{
        return false;
    }
    
    @IBOutlet weak var faceIDOption: UISwitch!
    
    @IBAction func faceIDToggled(_ sender: Any) {
    }
    
    
    @IBAction func sendFeedback(_ sender: Any) {
        sendEmail()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["paulba71@hotmail.com"])
            mail.setSubject("Feedback on iOS App - Key Info")
            mail.setMessageBody("<p>Please add comments here!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
