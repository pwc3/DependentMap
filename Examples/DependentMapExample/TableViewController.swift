//
//  TableViewController.swift
//  DependentMap
//
//  Copyright (c) 2019 Anodized Software, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var previousLaunchDateLabel: UILabel!

    @IBOutlet var darkModeSwitch: UISwitch!

    private var defaultTableViewBackground: UIColor?

    private var useDarkMode: Bool = false {
        didSet {
            // update the switch to match the bool
            darkModeSwitch.isOn = useDarkMode

            // set the background color of the table view for "dark mode"
            tableView.backgroundColor =
                useDarkMode ? UIColor(white: 0.1, alpha: 1.0) : defaultTableViewBackground
        }
    }

    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .medium
        df.timeZone = TimeZone.current

        return df
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // save the default background color
        defaultTableViewBackground = tableView.backgroundColor

        // populate the previous launch date in the UI
        let date = UserDefaults.standard.value(for: .previousLaunchDate).map { dateFormatter.string(from: $0) }
        previousLaunchDateLabel.text = "\(date ?? "none")"

        // save the current date as the previous launch date for next time
        UserDefaults.standard.set(Date(), for: .previousLaunchDate)

        // configure dark mode
        useDarkMode = UserDefaults.standard.value(for: .darkMode) ?? false
    }

    @IBAction func darkModeSwitchChanged(_ sender: Any) {
        useDarkMode = darkModeSwitch.isOn

        // save the updated setting
        UserDefaults.standard.set(useDarkMode, for: .darkMode)
    }
}
