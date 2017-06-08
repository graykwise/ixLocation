//
//  AddActivityViewController.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/5/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import UIKit
import Alamofire

class AddActivityViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    var delegate: AddActivityDelegate?
    var newActivity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.didCancelActivity()
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func saveActivity(_ sender: UIBarButtonItem) {
        
        if(nameTextField.text != "" && descriptionText.text != ""){
            
        newActivity?.name = nameTextField.text!
        newActivity?.description = descriptionText.text
            
        Alamofire.request("https://ixlocation-b31d5.firebaseio.com/activities.json", method: .post, parameters: newActivity?.toJSON(), encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let _):
                self.delegate?.didSaveActivity(activity: self.newActivity!)
                self.dismiss(animated: true, completion: nil)
            case .failure: break
                // Failure... handle error
            }
            }
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Please Fill Out All Fields", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
