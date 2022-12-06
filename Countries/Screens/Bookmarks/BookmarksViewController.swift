//
//  BookmarksViewController.swift
//  Countries
//
//  Created by Chandrachudh K on 01/12/22.
//

import Combine
import UIKit

class BookmarksViewController: UIViewController {
    // MARK: UI Elements Outlets
    @IBOutlet weak var searchBaseView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var lblFilterType: UILabel!
    
    // MARK: Private Properties
    private var bookmarksViewModel: BookmarksViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    convenience init(bookmarksViewModel: BookmarksViewModel) {
        self.init()
        self.bookmarksViewModel = bookmarksViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupHeaderView()
        setupBookmarksTableView()
    }
    
    // MARK: UI Setup Methods
    private func setupHeaderView() {
        searchBaseView.makeRounded()
        txtSearch.delegate = self
    }
    
    private func setupBookmarksTableView() {
        bookmarksTableView.registerCellWithXib(reuseIdentifier: BookmarkCell.reuseIdentifier)
        
        bookmarksTableView.separatorColor = .clear
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        bookmarksTableView.reloadData()
        
        setupSubscriptions()
    }
    
    // MARK: Subscriptions setup
    private func setupSubscriptions() {
        bookmarksViewModel.$filteredCountries
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.lblFilterType.text = self?.bookmarksViewModel.filterDescription 
                self?.bookmarksTableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    
    // MARK: Target Methods
    @IBAction func didTapDismissButton(_ sender: Any) {
        bookmarksViewModel.dismiss = true
    }
    
    @IBAction func didTapFilterButton(_ sender: Any) {
        var actions = [UIAlertAction]()
        
        for filterType in BookmarkFilter.allCases {
            let action = UIAlertAction(title: filterType.optionTitle,
                                       style: .default) { [weak self] action in
                self?.bookmarksViewModel.selectedFilter = filterType
            }
            actions.append(action)
        }
        actions.append(.cancelAction)
        
        showActionSheet(title: "Filter Bookmarked Countries",
                        message: "Select an option to filter the bookmarked countries",
                        actions: actions,
                        sourceView: btnFilter)
    }
}

// MARK: UITextfield Support
extension BookmarksViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text {
            let updatedText = (text as NSString).replacingCharacters(in: range, with: string)
            self.bookmarksViewModel.search(for: updatedText)
        }
        return true
    }
    
}

// MARK: UITableview Support
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarksViewModel.bookmarksCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.reuseIdentifier, for: indexPath) as! BookmarkCell
        cell.populateCell(country: bookmarksViewModel.filteredCountries[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookmarksViewModel.selectedCountry = bookmarksViewModel.filteredCountries[indexPath.row]
    }
}
