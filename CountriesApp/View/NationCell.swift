//
//  NationCell.swift
//  CountriesApp
//
//  Created by Anusha Raju on 5/02/25.
//

import UIKit

class NationCell: UITableViewCell {
    static let reuseID = "NationCell"

    private let nameRegion = UILabel()
    private let capital = UILabel()
    private let code = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    private func setup() {
        nameRegion.font = .preferredFont(forTextStyle: .headline)
        code.font = .preferredFont(forTextStyle: .body)
        code.textAlignment = .right
        capital.font = .preferredFont(forTextStyle: .subheadline)
        capital.textColor = .secondaryLabel

        let topStack = UIStackView(arrangedSubviews: [nameRegion, code])
        topStack.axis = .horizontal
        topStack.spacing = 8

        let fullStack = UIStackView(arrangedSubviews: [topStack, capital])
        fullStack.axis = .vertical
        fullStack.spacing = 6
        fullStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(fullStack)

        NSLayoutConstraint.activate([
            fullStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            fullStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            fullStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fullStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    func configure(with model: Nation) {
        nameRegion.text = "\(model.name ?? "Unknown"), \(model.region ?? "--")"
        code.text = model.code
        capital.text = model.capital
    }
}
