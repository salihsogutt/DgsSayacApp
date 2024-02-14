//
//  ViewController.swift
//  DgsSayacApp
//
//  Created by salih söğüt on 6.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var saniyeLabel: UILabel!
    @IBOutlet weak var dakikaLabel: UILabel!
    @IBOutlet weak var saatLabel: UILabel!
    @IBOutlet weak var gunLabel: UILabel!
    @IBOutlet weak var motivasyonLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var blurBackView2: UIView!
    @IBOutlet weak var blurBackView: UIVisualEffectView!
    
    var motivasyonSozleri = [String]()
    
    var timer: Timer?
    var remainingTime: Int = 0
    
    var randomIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motiveSozler()
        
        geriSayim()
        
    }
    
    
    func geriSayim() {
        // İkinci tarih
        let secondDate = DateComponents(calendar: .current, year: 2024, month: 6, day: 30, hour: 10, minute: 15, second: 10).date!
        
        // Tarihler arasındaki farkı hesapla
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: Date(), to: secondDate)
        
        // Toplam saniyeyi hesapla
        if let totalSeconds = components.second {
            remainingTime = totalSeconds
            
            // Timer başlat
            startTimer()
        } else {
            saatLabel.text = "Hata: Tarihler arasındaki saat farkı hesaplanamadı."
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if remainingTime > 0 {
            let days = remainingTime / (24 * 3600)
            let hours = (remainingTime % (24 * 3600)) / 3600
            let minutes = (remainingTime % 3600) / 60
            let seconds = remainingTime % 60
            
            gunLabel.text = String(days)
            saatLabel.text = String(hours)
            dakikaLabel.text = String(minutes)
            saniyeLabel.text = String(seconds)
            
            remainingTime -= 1
        } else {
            // Geri sayım tamamlandıysa, timer'ı durdur
            timer?.invalidate()
            timer = nil
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        let selectedSoz = motivasyonSozleri[randomIndex] // Seçilen sözü alın
        
        // UIActivityViewController oluşturun ve paylaşılacak metni ayarlayın
        let activityViewController = UIActivityViewController(activityItems: [selectedSoz], applicationActivities: nil)
        
        // UIActivityViewController'ı gösterin
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func copyButtonTapped(_ sender: UIButton) {
        
        let selectedSoz = motivasyonSozleri[randomIndex] // Seçilen sözü alın
        UIPasteboard.general.string = selectedSoz // Seçilen sözü panoya kopyalayın
        
        // Kullanıcıya kopyalandı mesajı gösterin
        let alert = UIAlertController(title: "Başarılı", message: "Söz kopyalandı: \(selectedSoz)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func motiveSozler(){
        
        motivasyonSozleri = ["Bugün yapmadığın şey, yarın istediğin sonucu elde etmene engel olabilir.","Başarı, pes etmeyenlerin sonucudur.","Hayallerine inan ve onların peşinden git. Unutma, imkansız sadece düşünce tarzımızın sınırlarını yansıtır.","İmkansız görüneni başarmak için, yapman gereken tek şey o işe başlamaktır.","Düşmenin değil, kalkmanın önemi vardır.","Her adım, bir öncekinden daha büyük bir başlangıçtır.","Başarı, korkularınızın ötesindedir.","Düşlerinizin peşinden koşun. Onlar gerçekten değerlidir.","Zorluklar, güçlü insanların hayatındaki basamaklardır.","Küçük adımlar, büyük başarıların temelidir.","Zorluklar, hayatın bize sunduğu gelişim fırsatlarıdır.","Pes etmek, zaferin tam ortasında olduğunuz zaman yapmamanız gereken bir şeydir.","Başarı, zorlukların üstesinden gelmeyi denemekte başarılı olanların hikayesidir.","Yarının ne getireceğini asla bilemezsiniz, bu yüzden bugün en iyisini yapın.","Kendinize inanın, başkalarının ne dediği önemli değil. Siz yapabilirsiniz!"]
        
        randomIndex = Int.random(in: 0..<motivasyonSozleri.count) // Rastgele bir dizin seçin
        let selectedSoz = motivasyonSozleri[randomIndex] // Seçilen sözü alın
        
        motivasyonLabel.text = selectedSoz
        
    }
}




