//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 27/09/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var scColors: UISegmentedControl!
    @IBOutlet weak var swAutoPlay: UISwitch!
    @IBOutlet weak var tfGenre: UITextField!
    
    var pickerView: UIPickerView!
    
    let genres = ["Acao", "Drama", "Suspense", "Comedia", "Terror"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
        
        //view q serve de entrada para o
        tfGenre.inputView = pickerView
        tfGenre.delegate = self
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let okButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        toolbar.items = [okButton, spaceButton, cancelButton]
        
        //view q aparece em cima da input view
        tfGenre.inputAccessoryView = toolbar

    }
    
    //vai persistir a informacao
    func done() {
        
        //devolve a linha selecionada daquele pickerview
        tfGenre.text = genres[pickerView.selectedRow(inComponent: 0)]
        UserDefaults.standard.set(tfGenre.text!, forKey: "genre")
        cancel()
    }
    
    func cancel() {
        tfGenre.resignFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(tfGenre.text!, forKey: "genre")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //obtendo os valores do user_default
        scColors.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "color")
        
        //definir o valor do switch (botao)
        swAutoPlay.setOn(UserDefaults.standard.bool(forKey: "autoplay"), animated: false)
        tfGenre.text = UserDefaults.standard.string(forKey: "genre")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //userDefault eh um dicionario gigante que pode ser lido em qlqr lugar do app
    //eh o meu SharedPreferences

    @IBAction func changeColor(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "color")
    }
    
    @IBAction func changeAutoPlay(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "autoplay")
    }
    
}


extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
}

extension SettingsViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
