//
//  AnotacaoViewController.swift
//  Notas Diarias
//
//  Created by Bruno Lopes de Mello on 12/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    @IBAction func salvar(_ sender: Any) {
        
        if anotacao != nil {//atualizar
            self.atualizarAnotacao()
        } else {
            
            self.salvarAnotacao()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if anotacao != nil {//atualizar
            self.texto.text = anotacao.value(forKey: "texto") as! String
        } else {
            self.texto.text = ""
        }
        
        self.texto.becomeFirstResponder()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    private func atualizarAnotacao() {
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try self.context.save()
            print("Anotacao atualizada com sucesso")
        } catch let erro {
            print("Erro ao atualizar anotacao: " + erro.localizedDescription)
        }
    }
    
    private func salvarAnotacao() {
        //criar objeto para anotacao
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        //configura anotacao
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do {
            try self.context.save()
            print("Anotacao salva com sucesso")
        } catch let erro {
            print("Erro ao salvar anotacao: " + erro.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
