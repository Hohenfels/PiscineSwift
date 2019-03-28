import UIKit

class ViewController: UIViewController {
 
    
    var nbOnScreen : Int = 0
    var prevNumber : Int = 0
    var performOp = false
    var op = 0;
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func negFunc(_ sender: UIButton) {
        print("Pressing NEG button")
        nbOnScreen *= -1
        if nbOnScreen == 0
        {
            return
        }
        resultLabel.text = String(nbOnScreen)
    }
    
    @IBAction func nbButton(_ sender: UIButton)
    {
        //Use tag to get number associated to the button
        print("Pressing button : \(sender.tag - 1)")
        if (nbOnScreen >= 999999999999999999 || nbOnScreen <= -999999999999999999 || prevNumber >= 999999999999999999 || prevNumber <= -999999999999999999)
        {
            print("Error: Overflow, resetting the calculator")
            reset()
        }
        if performOp == true
        {
            resultLabel.text = String(sender.tag - 1)
            nbOnScreen = Int(resultLabel.text!)!
            performOp = false
        }
        else
        {
            resultLabel.text = resultLabel.text! + String(sender.tag - 1)
            nbOnScreen = Int(resultLabel.text!)!
        }
    }
    
    
    @IBAction func funcButton(_ sender: UIButton)
    {
        /*
        Same as the nb buttons
        11 - 12 are AC - NEG
        13 - 16 are + * - /
        17 is =
        */
        if resultLabel.text != "" && sender.tag != 11 && sender.tag != 17
        {
            if self.resultLabel.text?.first == "-" || isdigit(Int32(self.resultLabel.text!.utf8CString.first!)) != 0
            {
                prevNumber = Int(resultLabel.text!)!
            }
            if sender.tag == 13 // +
            {
                resultLabel.text = "+"
                print("Pressing +")
            }
            else if sender.tag == 14 // *
            {
                resultLabel.text = "*"
                print("Pressing *")
            }
            else if sender.tag == 15 // -
            {
                resultLabel.text = "-"
                print("Pressing -")
            }
            else if sender.tag == 16 // /
            {
                resultLabel.text = "/"
                print("Pressing /")
            }
            op = sender.tag
            if nbOnScreen != 0 && prevNumber != 0
            {
                performOp = true
            }

        }
        else if sender.tag == 17
        {
            if op == 13
            {
                print("Doing math +")
                resultLabel.text = String(prevNumber &+ nbOnScreen)
                nbOnScreen = Int(resultLabel.text!)!
            }
            else if op == 14
            {
                print("Doing math *")
                resultLabel.text = String(prevNumber &* nbOnScreen)
                nbOnScreen = Int(resultLabel.text!)!
            }
            else if op == 15
            {
                print("Doing math -")
                resultLabel.text = String(prevNumber &- nbOnScreen)
                nbOnScreen = Int(resultLabel.text!)!
            }
            else if op == 16
            {
                if nbOnScreen != 0
                {
                    print("Doing math /")
                    resultLabel.text = String(prevNumber / nbOnScreen)
                    nbOnScreen = Int(resultLabel.text!)!
                }
                else
                {
                    print("Error: Dividing by 0")
                    reset()
                }
            }
            if (nbOnScreen >= 999999999999999999 || nbOnScreen <= -999999999999999999 || prevNumber >= 999999999999999999 || prevNumber <= -999999999999999999)
            {
                print("Error: Overflow, resetting the calculator")
                reset()
            }
        }
        else if sender.tag == 11
        {
            print("Presing reset button")
            reset()
        }
    }
    
    func reset()
    {
        resultLabel.text = ""
        prevNumber = 0
        nbOnScreen = 0
        op = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

