//
//  HomeViewController.swift
//  Countries
//
//  Created by Chandrachudh K on 24/11/22.
//

import Combine
import DeviceKit
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: UI Elements Outlets
    @IBOutlet weak var searchViewBase: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var recentSearchesView: UIView!
    @IBOutlet weak var recentSearchesCollectionView: UICollectionView!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var imgNoResult: UIImageView!
    
    // MARK: Private properties
    private var searchViewModel: SearchViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    convenience init(searchViewModel: SearchViewModel) {
        self.init()
        self.searchViewModel = searchViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        subscribeToSearch()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: UI Setup Methods
    private func setupUI() {
        setupSearchView()
        setupResultsCollectionView()
        
        // Hide all views in the stackview. We will show these view when the user starts to search for a country
        recentSearchesView.isHidden = true
        resultsView.isHidden = true
        imgNoResult.isHidden = true
    }
    
    private func setupSearchView() {
        searchViewBase.makeRounded()
        txtSearch.delegate = self
    }
    
    private func setupResultsCollectionView() {
        // Register the collection view cell to the resultsCollectionView
        resultsCollectionView.registerCellWithXib(reuseIdentifier: ResultCell.reuseIdentifier)
        
        // Custom layout for the resultsCollectionView
        let itemWidth = ResultCell.itemWidth
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = ResultCell.gap
        layout.minimumInteritemSpacing = ResultCell.gap
        layout.sectionInset = UIEdgeInsets(top: ResultCell.offset, left: ResultCell.offset, bottom: ResultCell.offset, right: ResultCell.offset)
        resultsCollectionView.setCollectionViewLayout(layout, animated: false)
        
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        resultsCollectionView.reloadData()
    }
    
    // MARK: Subscribe SearchViewModel Publishers
    private func subscribeToSearch() {
        // Subscribe for Searchresults
        searchViewModel.$searchResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchResults in
                // Update the resultsCollectionview/lblNoResults label here
                if searchResults.isEmpty {
                    self?.resultsView.isHidden = true
                    self?.imgNoResult.isHidden = false
                } else {
                    self?.imgNoResult.isHidden = true
                    self?.resultsView.isHidden = false
                    self?.resultsCollectionView.reloadData()
                }
            }
            .store(in: &subscriptions)
        
        searchViewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let strongSelf = self, !errorMessage.isEmpty else {
                    return
                }
                strongSelf.showAlert(title: "Error", message: errorMessage, actions: [.okAction])
            }
            .store(in: &subscriptions)
    }
    
    // MARK: Uitility Methods
    @objc private func searchForCountry() {
        // Make Search Request here
        searchViewModel.search(for: txtSearch.text)
    }
    
    // MARK: Target Methods
    @IBAction func didTapBookmarksButton(_ sender: Any) {
        searchViewModel.showBookMarks = true
    }
    
}

// MARK: UTextfield Support
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        searchForCountry()
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text {
            let updatedText = (text as NSString).replacingCharacters(in: range, with: string)
            if updatedText.count < 3 {
                searchViewModel.clearSearch()
            }
            searchViewModel.search(for: updatedText)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchViewModel.clearSearch()
        return true
    }
}

// MARK: UICollectionView Support
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCell.reuseIdentifier, for: indexPath) as! ResultCell
        
        cell.populateView(country: searchViewModel.getCountry(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        searchViewModel.didSelect(country: searchViewModel.getCountry(at: indexPath.row))
    }
    
    
    // When the user starts to tap the cell show an animation for feedback
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    // User tap release feedback animation
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = .identity
        }
    }
    
    // Dismiss keyboard on collection view scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
