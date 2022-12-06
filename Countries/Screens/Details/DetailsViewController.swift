//
//  DetailsViewController.swift
//  Countries
//
//  Created by Chandrachudh K on 25/11/22.
//

import Combine
import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: UI ELEMENT IBOutlets
    @IBOutlet weak var headerBGView: UIView!
    @IBOutlet weak var headerBGShadowView: UIView!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblOfficalName: UILabel!
    @IBOutlet weak var lblCommonName: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var imgCoatOfArms: UIImageView!
    @IBOutlet weak var imgInterest: UIImageView!
    @IBOutlet weak var lblInterest: UILabel!
    
    
    // MARK: Private Properties
    private var countryViewModel: CountryDetailsViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    convenience init(countryViewModel: CountryDetailsViewModel) {
        self.init()
        self.countryViewModel = countryViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupImagesUI()
        setupNameUI()
        setupDetailsUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMasksAndShadows()
    }
    
    // MARK: UI Setup Methods
    private func setupImagesUI() {
        imgFlag.setImage(url: countryViewModel.flagURL) {
        }
        imgCoatOfArms.setImage(url: countryViewModel.coatOfArmsURL) {
        }
        imgCoatOfArms.layer.cornerRadius = 4.0
    }
    
    private func setupNameUI() {
        lblOfficalName.text = countryViewModel.officialName
        lblCommonName.text = countryViewModel.commonName
    }
    
    private func setupMasksAndShadows() {
        headerBGView.maskCorners([.bottomLeft, .bottomRight], cornerRadius: 20)
        headerBGShadowView.addShadowWith(shadowPath: headerBGShadowView.getCornerMaskedPath(mask: [.bottomLeft, .bottomRight],
                                                                                            cornerRadius: 20).cgPath,
                                         shadowColor: UIColor.shadow.cgColor,
                                         shadowOpacity: 0.5,
                                         shadowRadius: 4.0,
                                         shadowOffset: .zero)
    }
    
    private func setupDetailsUI() {
        // We give footer view a height to make sure that the contents at the bottom of the table become visible when scrolled down. We have made the table views bottom inset aligned out of bottom safe area inset
        detailsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SAFE_BOTTOM_INSET))
        
        // Regsiter all the cell we are using in the tableview
        detailsTableView.registerCellWithXib(reuseIdentifier: InfoCell.reuseIdentifier)
        detailsTableView.registerCellWithXib(reuseIdentifier: ReviewCell.reuseIdentifier)
        detailsTableView.registerCellWithXib(reuseIdentifier: AddReviewCell.reuseIdentifier)
        detailsTableView.registerCellWithXib(reuseIdentifier: LanguageTableViewCell.reuseIdentifier)
        detailsTableView.registerCellWithXib(reuseIdentifier: UNAndIndependanceCell.reuseIdentifier)
        detailsTableView.registerHeaderFooterView(reuseIdentifier: "DetailsHeaderView")
        
        detailsTableView.separatorColor = .clear
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        subscribeToReviews()
        subscribeToInterest()
    }
    
    // MARK: Subscriptions
    private func subscribeToReviews() {
        self.countryViewModel.$refreshView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldRefresh in
                if shouldRefresh {
                    self?.detailsTableView.reloadData()
                    self?.countryViewModel.refreshView = false
                }
            }
            .store(in: &subscriptions)
    }
    
    private func subscribeToInterest() {
        self.countryViewModel.$interest
            .receive(on: DispatchQueue.main)
            .sink { [weak self] interest in
                self?.updateUIWithInterest(interest: interest)
            }
            .store(in: &subscriptions)
    }
    
    private func updateUIWithInterest(interest: Interest) {
        UIView.animate(withDuration: 0.1, delay: 0.0) {
            self.lblInterest.alpha = 0.0
            self.imgInterest.alpha = 0.0
        } completion: { _ in
            self.lblInterest.text = interest.description
            self.imgInterest.image = UIImage(systemName: interest.imageName)
            self.imgInterest.tintColor = interest.imageColor
            
            UIView.animate(withDuration: 0.15, delay: 0.0) {
                self.lblInterest.alpha = 1.0
                self.imgInterest.alpha = 1.0
            } completion: { _ in
            }
        }
    }
    
    // MARK: Target Methods
    @IBAction func didTapFlagButton(_ sender: Any) {
        // Show a large image of the flag
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        countryViewModel.didTapBack = true
    }
    
    @IBAction func didTapNameSpeaker(_ sender: Any) {
        countryViewModel.utterCountryCommonName()
    }
    
    @IBAction func didTapCoatOfArms(_ sender: Any) {
        // Show a large image of the coat of arms
    }
    
    @IBAction func didTapNewReviewbutton(_ sender: Any) {
        countryViewModel.addReview = true
    }
    
    @IBAction func didTapUpdateReviewButton(_ sender: Any) {
        var actions = [UIAlertAction]()
        for interest in Interest.listOfAllCases {
            let action = UIAlertAction(title: interest.optionTitle, style: .default) { [weak self] action in
                self?.countryViewModel.interest = interest
            }
            actions.append(action)
        }
        
        actions.append(.cancelAction)
        showActionSheet(title: "Are you interested to visit this country?",
                        message: "Select from the option below",
                        actions: actions,
                        sourceView: imgInterest)
    }
    
    @IBAction func didTapMapPin(_ sender: Any) {
        countryViewModel.openInMaps()
    }
    
}

// MARK: UITableview Support
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        countryViewModel.reviewsCount == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailsHeaderView") as! DetailsHeaderView
        header.lblSectionTitle.text = section == 0 ? "Demographics" : "Reviews"
        header.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return countryViewModel.reviewsCount == 0 ? countryViewModel.detailsCellTypes.count : countryViewModel.detailsCellTypes.count - 1
        default:
            return countryViewModel.reviewsCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch countryViewModel.detailsCellTypes[indexPath.row] {
            case .demographics:
                let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseIdentifier, for: indexPath) as! InfoCell
                cell.populate(with: countryViewModel.infoViewModel)
                cell.selectionStyle = .none
                return cell
            case .languages:
                let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.reuseIdentifier, for: indexPath) as! LanguageTableViewCell
                cell.selectionStyle = .none
                cell.populate(languages: countryViewModel.langaugesViewModel)
                return cell
            case .unAndIndepence:
                let cell = tableView.dequeueReusableCell(withIdentifier: UNAndIndependanceCell.reuseIdentifier, for: indexPath) as! UNAndIndependanceCell
                cell.selectionStyle = .none
                cell.populate(with: countryViewModel.demoGraphicsViewModel)
                return cell
            case .noReview:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddReviewCell.reuseIdentifier, for: indexPath) as! AddReviewCell
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        cell.selectionStyle = .none
        cell.populate(with: countryViewModel.getReviewViewModel(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == DetailType.noReview.rawValue {
            // The user did tap add review cell
            countryViewModel.addReview = true
        }
    }
}
