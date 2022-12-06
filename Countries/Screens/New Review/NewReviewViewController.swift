//
//  NewReviewViewController.swift
//  Countries
//
//  Created by Chandrachudh K on 28/11/22.
//

import DeviceKit
import UIKit

class NewReviewViewController: UIViewController {
    
    // MARK: UI Elements Outlets
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var titleBaseView: UIView!
    @IBOutlet weak var txtReviewTitle: UITextField!
    @IBOutlet weak var reviewBaseView: UIView!
    @IBOutlet weak var txtReview: UITextView!
    
    // MARK: Private Properties
    private var newReviewViewModel: NewReviewViewModel!
    
    convenience init(newReviewViewModel: NewReviewViewModel) {
        self.init()
        self.newReviewViewModel = newReviewViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTitleSection()
        setupReviewSection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addShadows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtReviewTitle.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: Setup UI
    private func setupTitleSection() {
        lblCountry.text = newReviewViewModel.countryName
        titleBaseView.layer.cornerRadius = CORNER_RADIUS
        txtReviewTitle.delegate = self
    }
    
    private func setupReviewSection() {
        reviewBaseView.layer.cornerRadius = CORNER_RADIUS
        txtReview.layer.cornerRadius = CORNER_RADIUS
        txtReview.delegate = self
    }
    
    private func addShadows() {
        reviewBaseView.addShadow()
        titleBaseView.addShadow()
        txtReview.addShadow()
    }
    
    // MARK: Target Methods
    @IBAction func didTapDismissButton(_ sender: Any) {
        view.endEditing(true)
        newReviewViewModel.dismissReviewPage()
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        view.endEditing(true)
        
        guard let review = txtReview.text, !review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Error",
                      message: "Please add a review",
                      actions: [.okAction])
            return
        }
        
        newReviewViewModel.saveReview(title: txtReviewTitle.text, review: txtReview.text)
    }
}

// MARK: UITextField Support
extension NewReviewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtReview.becomeFirstResponder()
        return true
    }
}

// MARK: UITextView Support
extension NewReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !Device.current.isPad && !Device.current.hasRoundedDisplayCorners {
            lblCountry.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        lblCountry.isHidden = false
    }
}
