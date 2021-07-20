//
//  ArtistTopTracksVC.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 18.07.2021.
//

import UIKit

protocol ArtistTopTracksViewModelProtocol {
    var title: String { get }
    var simplifiedTracks: [SimpleTrack] { get }
    
    func fetchArtistTopTracks(completion: @escaping () -> Void)
    func back()
}

class ArtistTopTracksVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var songsTableView: UIView!
    
    var viewModel: ArtistTopTracksViewModelProtocol?
    private let tableViewTracks = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAndConfigureTable()
    }
    
    @IBAction private func back(_ sender: UIButton) {
        viewModel?.back()
    }
    
    func fetchAndConfigureTable() {
        viewModel?.fetchArtistTopTracks {
            DispatchQueue.main.async {
                self.titleLabel.text = self.viewModel?.title
                self.configureTable()
            }
        }
    }
    
    private func configureTable() {
        self.songsTableView.addSubview(tableViewTracks)
        tableViewTracks.translatesAutoresizingMaskIntoConstraints = false
        tableViewTracks.frame = self.songsTableView.bounds
        tableViewTracks.register(SongTableCell.self, forCellReuseIdentifier:
                                    String(describing: type(of: SongTableCell.self)))
        tableViewTracks.delegate = self
        tableViewTracks.dataSource = self
        tableViewTracks.backgroundColor = .clear
        tableViewTracks.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

// MARK: - UITableView
extension ArtistTopTracksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.simplifiedTracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                        String(describing: type(of: SongTableCell.self))) as? SongTableCell else {
            return UITableViewCell()
        }
        
        guard let song = viewModel?.simplifiedTracks[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setTrack(song: song)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
