//
//  TaskListViewController.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 1/23/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: TableViewController {    
    private lazy var emptyTaskListLabel: UILabel = {
        let label = UILabel()
        tableView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configureAccent()
        label.font = label.font.withSize(20.0)
        label.text = "No tasks"
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
        
        return label
    }()
    
    private let presenter: TaskListPresenterProtocol
    
    init(presenter: TaskListPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        barButtonItem.configureDefault()
        barButtonItem.rx.tap
            .subscribe(onNext: { _ in self.presenter.makeTask() })
            .disposed(by: self)
        navigationItem.rightBarButtonItem = barButtonItem
        
        presenter.requestTaskList()
    }
}

//MARK: - TaskListViewProtocol

extension TaskListViewController: TaskListViewProtocol {
    func taskListGroupConfigurator() -> TableViewCellPersistableConfigurator<Task> {
        return TableViewCellPersistableConfigurator(
            dequeueCell: { cellProvider, task in
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .short
                
                let cell = cellProvider.reusableCell() as TaskTableViewCell
                cell.accessoryType = .disclosureIndicator
                cell.nameLabel.text = task.name    
                cell.dateLabel.text = task.date.map(dateFormatter.string(from:))
                
                return cell
        },
            onSelect: { [unowned self] task, deselect in
                deselect()
                self.presenter.select(task)
            },
            actions: { [unowned self] task in
                return [UITableViewRowAction(style: .destructive, title: "Delete", handler: { _, _ in
                    self.presenter.delete(task)
                })]
        })
    }
    
    func show(_ taskListGroup: TableViewCellGroupController) {
        let section = TableViewSectionController(
            name: "Tasks",
            cellGroups: [taskListGroup]
        )
        sectionsController = TableViewSectionsController(sections: [section])
    }
    
    func showTaskList(error: Error) {
        sectionsController = TableViewSectionsController(sections: [])
    }
    
    func showTaskList(empty: Bool, context: AnimationContext) {
        let hidden = !empty
        
        let animations = [AlphaAnimator(hidden: hidden), SlideAnimator(hidden: hidden)] as [AnimatorProtocol]
        animations.forEach { $0.animate(emptyTaskListLabel, in: context, completion: { _ in }) }
    }
    
    private func show(_ taskListGroup: TableViewCellGroupController?, error: Error?) {
        let section = TableViewSectionController(name: "Tasks", cellGroups: taskListGroup.map { [$0] } ?? [])
        sectionsController = TableViewSectionsController(sections: [section])
    }
}
