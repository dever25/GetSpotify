//
//  TopArtistViewController.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 16.07.2021.
//

import UIKit

protocol TopArtistViewModelProtocol {
    var artists: TopArtistModel { get }
    func getUserTopArtists(completion: @escaping () -> Void)
    func tabOnArtist(index: Int)
}

class TopArtistViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UIView!
    
    var viewModel: TopArtistViewModelProtocol?
    private let tableViewUserArtists = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        fetchAndConfigureTable()
    }
    
    private func fetchAndConfigureTable() {
        viewModel?.getUserTopArtists {
            self.configureTableView()
        }
    }
    
    private func configureNavBar() {
        self.titleLabel.text = "Top Artists"
    }
    
    private func configureTableView() {
        tableViewUserArtists.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.addSubview(tableViewUserArtists)
        tableViewUserArtists.register(ArtistTableCell.self,
                                      forCellReuseIdentifier: String(describing: type(of: ArtistTableCell.self)))
        tableViewUserArtists.dataSource = self
        tableViewUserArtists.delegate = self
        tableViewUserArtists.frame = self.tableView.bounds
        tableViewUserArtists.backgroundColor = .clear
        tableViewUserArtists.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

// MARK: - UITableView
extension TopArtistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.artists.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                        String(describing: type(of: ArtistTableCell.self))) as? ArtistTableCell,
              let artist = viewModel?.artists.items[indexPath.row] else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        cell.setArtist(artist: artist)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.tabOnArtist(index: indexPath.row)    }
}
