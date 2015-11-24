//
//  ViewController.swift
//  lebowski_test
//
//  Created by Joshua Yancey on 05/03/2015.
//  Copyright (c) 2015 BK2UK. All rights reserved.
//

import UIKit
import AVFoundation
import iAd




class ViewController: UIViewController, UITextViewDelegate, ADInterstitialAdDelegate {
    
    //trying to keep shabbos warning only once per load
    var shabbosWarning:Bool = false
    
    //counter var for loading ads
    var counter:Int = 0
    
    //iAd stuff
    var interstitialAd:ADInterstitialAd!
    var interstitialAdView: UIView = UIView()
    
    //stuff for iAds. note the delegate added above
    var closeButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    
    
    
    //using this to clear the text on entering edit for the textView
    var placeHolderText = "Type your quandary here, man."
    
    //needed for the audio player
    var player:AVAudioPlayer = AVAudioPlayer()
    
    //setting array here
    
    //0-10
    var files = ["believeInNothing", "thatsWhyPickedUpPhone", "shomerShabbos", "hateEagles", "eightYearOlds", "pervert", "whatsPederast", "sexOffender", "nihilistsFuckMe", "whosTheNihilist", "ethos",
        
        //11-20
        "splitHairs", "cowards", "nothingToBeAfraidOf", "tomorrowCutJohnson", "dickRodJohnson", "needMyJohnson", "youMeanVagina", "vagina", "rugTiedDidItNot", "theyPeeYourRug",
        
        //21-30
        "manReallyTiedRoom", "allDudeWanted", "shomerShabbos", "dayOfRestShit", "dontRollShabbos", "shabbosExplain", "whatDayIsIt", "kahlua", "deineKabel", "expert",
        
        //31-40
        "expert", "fixesCable", "karlHungus", "knowThatGuy", "myNameKarl", "amIWrongOkThen", "notWrongAsshole", "yesYourWrong", "doYouSeeWhatHappens", "sonThisIsWhatHappens",
        
        //41-50
        "markItZeroYell", "markZero", "overTheLine", "thereAreRules", "worldPain", "worldCrazy", "diosMio", "eightYearOlds", "laughable", "readyFucked",
        
        //51-60
        "dontMatterJesus", "fucksJesus", "opinion", "unpostIt", "yeahWellDudeAbides", "thisYourHomework", "talkingAboutUncheckedAggression", "squareCommunity", "STFUDonny", "shitYeahAchievers",
        
        //61-70
        "samDudeAbidesComfort", "phonesRinging", "perfectlyCalm", "notTakingYourTurn", "notOnRugMan", "notGolfer", "nothingFucked", "nearInNOutBurger", "mosesToSandyKoufax", "listeningDudeStory",
        
        //71-80
        "fixesCable", "doJ", "checkWithCrimeLab", "beverage", "anotherToe", "givesShitMarmot", "shitYeahAchievers", "throwRocks", "pervert", "sexOffender",
        
        //81-90
        "overTheLine", "parlance", "maudeParlance", "feelFreeInspect", "standardsHaveFallen", "aintLegalEither", "queRidiculo", "diosMio", "franticallyTryingReachYouDude", "phonesRinging",
        
        //91-100
        "donnieElement", "readyFucked", "coitus", "vagina", "logjammingSong", "expert", "myNameKarl", "suckCockDollars", "specialLady", "itIsNoDream",
        
        //101-110
        "zestyEnterprise", "brainErogenous", "sexLoveCoitus", "aKidNamedLarrySellers", "arthurDigbySellers", "chiefOfPolice", "eightYearOlds", "fellaNamedLebowski", "fuckingQuintana", "karlHungus",
        
        //111-120
        "meAndSixOtherGuys", "theOtherJeffreyLebowski", "seattleSeven", "urbanAchievers", "whoFuckAreYou", "whoIsAtFaultWTF",  "whoIsThisGentleman", "WTFwithThisGuy", "fuckingNazis", "littleLebowskiUrbanAchievers",
        
        //121-130
        "cleftAsshole", "interestedParties", "bunchaAssholes", "fuckinBitch", "knowThatGuy", "knutsens", "bowlDriveAround", "cantDoThat", "doJ", "dontMatterJesus",
        
        //131-140
        "fuckItLetsBowl", "kahlua", "getJob", "finishingCoffee", "quietSTFU", "goToPasadena", "cantDoThat", "overTheLine", "goingHomeDonnie", "givesShitMarmot",
        
        //141-150
        "privateResidence", "fourAlmostFive", "illBeThereMan", "afterTheWhatHaveYa", "ralphsAround", "whereTheFuckYouGoingMan", "endingCheap", "livingInPast", "negativeEnergy", "noOneCutDickOff",
        
        //151-160
        "nothingFucked", "youFuckedItUp", "unspokenMessage", "fuckItThatsYourAnswer", "cantDoThat", "worldPain", "needBuckUp", "negativeEnergy", "awJesus",  "bummer",
        
        //161-170
        "cantBeWorriedAboutShit", "checkWithCrimeLab", "complexBlathering", "complicatedCaseMaude", "concern", "doJ", "donnieElement", "dontMatterJesus", "dudeAbides", "dudeIsNotIn",
        
        //171-180
        "dudeNothingFucked", "dudeWeJustDontKnow", "farOutShorter", "fuckinA", "fuckIt", "fuckItLetsBowl", "fuckItThatsYourAnswer", "fuckMeMan", "howShouldIKnow", "iDontKnowSir",
        
        //181-190
        "lifeDoesNotStart", "noMan", "noNotExactly", "noProblemo", "notGolfer", "notOccurredToUs", "ohNo", "ohYes", "popeShit", "privyToNewShit",
        
        //191-200
        "queRidiculo", "speakEnglish", "sureMan", "thatsPossibilityDude", "thatToDiscuss", "thisIsBummer", "thisIsPointless", "uptightThinking", "vinnieWTF", "wellYeah",
        
        //201-210
        "whatAreYouBlathering", "WTFtalkingAboutSam", "yesYourWrong", "quietSTFU",
        "acrossSandsOfTime", "afterTheWhatHaveYa", "dateWednesday", "dudeIsNotIn",
        "whatDayIsIt", "whenDoWePlaySaturday",
        
        //211-220
        "checkWithCrimeLab", "complexBlathering", "lifeDoesNotStart", "donnieElement", "dudeWeJustDontKnow",  "eatBear", "easternThing", "howShouldIKnow", "humanComedy", "iDontKnowSir", 
        
        //221-230
        "lostTrain", "thisIsPointless", "vinnieWTF", "aMillionClams", "fourAlmostFive", "hundredThousand", "tenPercentHalfMillion", "twentyGrandMan", "fuckingAmateurs", "fuckinLoser",
        
        
        //231-233
        "fuckYouUpTakesMoney", "readyFucked", "strikesAndGutters"]
    
    //audio player error thing
    var error:NSError? = nil
    

    
    //when only one track is needed for a response
    func oneTrack(trackNo: Int){
        
        //needed for audio player
        var fileLocation = NSString(string:NSBundle.mainBundle().pathForResource(files[trackNo], ofType: "mp3")!)
    
        //needed for audio player
        player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation), error: &error)
        
        //needed to play audio
        player.play()
    
    
    }
    

    
    
    //will choose a random number from a given range to select an appropriate quote from the array
    func randomMaker(min: Int, max:Int) {
        
        //this is the formula that gives the range between the numbers you choose
        var rando =  min + Int(arc4random_uniform(UInt32(max - min + 1)))
        
        println(rando)
        
        //trying to avoid the crash by putting this here to handle the problem with nil while unwrapping optional
        if rando > files.count {
        
            //needed for audio player
            var fileLocation = NSString(string:NSBundle.mainBundle().pathForResource(files[2], ofType: "mp3")!)
            
            //needed for audio player
            player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation), error: &error)
            
            //needed to play audio
            player.play()
            
            
            println("you got lucky bitch")
            
        
        } else {
        
        //needed for audio player
        var fileLocation = NSString(string:NSBundle.mainBundle().pathForResource(files[rando], ofType: "mp3")!)
        
        //needed for audio player
        player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation), error: &error)
        
        //needed to play audio
        player.play()
        
        }
        
        
    }
    
    //pretty self-explanatory
    @IBOutlet weak var question: UITextView! = UITextView()
    
    //get a random quote but not from the entire array. only a portion
    @IBAction func random(sender: AnyObject) {
        
        //these are the most memorable lines
        randomMaker(1, max: 78)
        
        
        println("random button")
        
        
        
        //making the ad display after 5 taps of the buttons.
        if counter < 5 {
        
            counter = counter + 1
            
        } else if counter == 5 {
            
            counter = 0
            loadInterstitialAd()
            println("ad Loaded")
            
            
        }
        
        println(counter)
        
    }
    
    func postParse(questionAsked:String){
       
        var asked = PFObject(className: "Questionz")
        asked.setObject(questionAsked, forKey: "Queries")
        
        asked.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            
            if success == true {
            
                return
            
            } else {
            
                return
            }
        
        }
    }
    
    
    
    @IBAction func getAdvice(sender: AnyObject) {
        
        
        //don't want to deal with case questions so setting this here to avoid it
        let smallString = question.text.lowercaseString
        
        
        var mute:Int = (countElements(smallString)) as Int
        
        
        
        //if the field is blank then do the 'we believe in nothing' quote because it's funny
        if smallString == "" {

            
            //only using one quote
            oneTrack(0)
            println("works")
            
            
        //if they don't enter a question, then they don't get an answer except "do you speak english?",
        } else if mute < 10 {
            
            oneTrack(192)
            println("mute")
        
        } else if let match = smallString.rangeOfString("eagle(s)?", options: .RegularExpressionSearch) {
        
            
            //"hateEagles"
            oneTrack(3)
            println("smartass")
            
            
            //running the regex search on the text and whatnot HOW MANY/MUCH SECTION
        } else if let match = smallString.rangeOfString("how (many|much|big|fat|fit)|bet", options: .RegularExpressionSearch){
            
            
            randomMaker(224, max: 228)
            println("how many")
            
            
            //running the regex search on the text and whatnot GAMING SECTION
        } else if let match = smallString.rangeOfString("win|game|match|team|lose", options: .RegularExpressionSearch){
            
            
            randomMaker(229, max: 233)
            println("gaming")
        
            
        
        } else if let match = smallString.rangeOfString("pederast|pervert|sex offender", options: .RegularExpressionSearch) {
            
            
            //"pervert", "whatsPederast", "sexOffender", "eightYearOlds"
            randomMaker(4, max: 7)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("nihilist(s)?|nazi(s)?", options: .RegularExpressionSearch) {
            
            
            //"nihilistsFuckMe", "whosTheNihilist", "ethos", "cowards", "nothingToBeAfraidOf", "splitHairs",
            randomMaker(8, max: 13)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("dick|rod|johnson", options: .RegularExpressionSearch) {
            
            
            //"tomorrowCutJohnson", "dickRodJohnson", "needMyJohnson", "youMeanVagina"
            randomMaker(14, max: 17)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("pussy|vagina|clam", options: .RegularExpressionSearch) {
            
            
            //"youMeanVagina"
            randomMaker(17, max: 18)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("rug|tie(d)?|carpet pisser|pee(d)?|carpet", options: .RegularExpressionSearch) {
            
            
            //"rugTiedDidItNot", "theyPeeYourRug", "manReallyTiedRoom", "allDudeWanted"
            randomMaker(19, max: 22)
            println("smartass")
            
        }  else if let match = smallString.rangeOfString("day of rest|shabbos|saturday", options: .RegularExpressionSearch) {
            
            
            //"shomerShabbos", "dayOfRestShit", "dontRollShabbos", "shabbosExplain", "whatDayIsIt"
            randomMaker(23, max: 27)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("kahlua|drink(ing)?|white russian", options: .RegularExpressionSearch) {
            
            
            //"kahlua"
            oneTrack(28)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("carl|karl|hungus|expert|kabel|cable|logjammin(g)?", options: .RegularExpressionSearch) {
            
            
            //"deineKabel", "expert", "fixesCable", "karlHungus", "knowThatGuy", "myNameKarl"
            randomMaker(29, max: 35)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("wrong", options: .RegularExpressionSearch) {
            
            
            //"amIWrongOkThen", "notWrongAsshole", "yesYourWrong"
            randomMaker(36, max: 38)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("what happens|fuck a stranger|do you see", options: .RegularExpressionSearch) {
            
            
            //"doYouSeeWhatHappens", "sonThisIsWhatHappens"
            randomMaker(39, max: 40)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("foul|over the line|mark it zero|mark it 0", options: .RegularExpressionSearch) {
            
            
            //"markItZeroYell", "markZero", "overTheLine", "thereAreRules", "worldPain", "worldCrazy"
            randomMaker(41, max: 46)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("wwjd|jesus|christ", options: .RegularExpressionSearch) {
            
            
            //"diosMio", "eightYearOlds", "laughable", "readyFucked", "dontMatterJesus", "fucksJesus"
            randomMaker(47, max: 52)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("suck(s)?|hate", options: .RegularExpressionSearch) {
            
            
            //"opinion"
            oneTrack(53)
            println("smartass")
            
        } else if let match = smallString.rangeOfString("facebook|status|post|fb", options: .RegularExpressionSearch) {
            
            
            //"unpostIt"
            oneTrack(54)
            println("smartass")
            
            
            
        //WHY QUESTIONS
        } else if let match = smallString.rangeOfString("why", options: .RegularExpressionSearch){
            
            
            randomMaker(211, max: 223)
            println("why")
            
            
        //WHEN QUESTIONS
        } else if let match = smallString.rangeOfString("when", options: .RegularExpressionSearch){
                
                
            randomMaker(205, max: 215)
            println("when")

        
        //running the regex search on the text and whatnot SEX SECTION
        } else if let match = smallString.rangeOfString("dick pic(s)?|nude(s)?|snapchat|sext(ing)?|porn|webcam|threesome|in bed|sex toy(s)?|tits|titties|vibrator|dildo|anal|lube|ass|snatch|cock|dtf|dat ass|bbob(s)?|butt|naked|slut|slag|cock|wang", options: .RegularExpressionSearch) {
            println("sex section")
            
            
            randomMaker(79, max: 91)
            
            
        //running the regex search on the text and whatnot LAID SECTION
        } else if let match = smallString.rangeOfString("friends with benefits|laid|sex|spend the night|fuckbuddy|bang|bj|blowjob|go down|fuck(ing)?|condom(s)?|birth control|sleep with|protection|hook(ing)? up|one night stand|hit it|hit that|tap that|tap dat|bone", options: .RegularExpressionSearch){
            
            
            randomMaker(92, max: 103)
            println("laid")
        
            
        //BREAK UP QUESTIONS
        } else if let match = smallString.rangeOfString("split(ting)? up|break(ing)? up|divorce(d)?|(quit|stop) seeing each other", options: .RegularExpressionSearch){
            
            
            randomMaker(147, max: 160)
            println("break up")

            
            
        //running the regex search on the text and whatnot WHO SECTION
        } else if let match = smallString.rangeOfString("who", options: .RegularExpressionSearch){
                
                
            randomMaker(104, max: 126)
            println("who")
          
            
        //WHAT SHOULD WE DO QUESTIONS
        } else if let match = smallString.rangeOfString("do\\b", options: .RegularExpressionSearch){
            
            
            randomMaker(127, max: 135)
            println("what")
         
        //WHERE SHOULD WE GO QUESTIONS
        } else if let match = smallString.rangeOfString("go\\b", options: .RegularExpressionSearch){
            
            
            randomMaker(136, max: 146)
            println("where")
            
            
        //SHOULD ETC.
        } else if let match = smallString.rangeOfString("^(has|have|should|is|are|will|can|could|am|did|does|would)", options: .RegularExpressionSearch){
            
            //this is the right range
            randomMaker(158, max: 204)
            println("yes-no-maybe")
          
            
        } else {
            
            
            randomMaker(211, max: 223)
            
            println("random catchall")
            
        }
        
        
        //posting the text of the question to parse for future reference
        if question.text == "" {
            
            println("pass")
            
        } else {
            
            postParse(smallString)
            
        }
        
        //setting the textView back to empty
        question.text = ""
        
        
        
        
        //making the ad display after 5 taps of the buttons.
        if counter < 4 {
            
            counter = counter + 1
            
        } else if counter == 4 {
            
            counter = 0
          //  loadAd()
            
            loadInterstitialAd()
            println("ad Loaded")
           
        }
        
        println(counter)
        
     

    }
    
    
    
    
    //setting this up. remember the issues regarding doing this WITHOUT a button.
    //If you put it in viewDidLoad there are hierarchy issues because the heirarchy doesn't exist yet
    //so put it in viewDidAppear
    func showAlertController () {
       
        var msgTitle:String = "It's Shomer Shabbos."
        var message:String = "Is this an emergency?"
        var btnNo:String = "No."
        var btnYes:String = "Yes."
        
        let alertController = UIAlertController(title: msgTitle, message: message, preferredStyle: .Alert)
        
    
    
        let actionLeft = UIAlertAction(title:btnNo, style: .Default) { action in
        
            self.oneTrack(2)
            println("Shomer Shabbos!")
        
        }
        
        let actionRight = UIAlertAction(title: btnYes, style: .Cancel) { action in
            
            
            self.oneTrack(1)
            println("I understand. That's why I picked up the phone.")
        
        }
        
        alertController.addAction(actionLeft)
        alertController.addAction(actionRight)

        
        self.presentViewController(alertController, animated: true, completion: nil)
       
    }
    
    
    //putting the alert here because in viewDidLoad it is not in the hierarchy yet
    override func viewDidAppear(animated: Bool) {
        
        NSLog("wtf")
        
        //needed for manipulating the textView. also don't forget the delegate at the top on the class UITextViewDelegate
        question.delegate = self
        //self.question.delegate = self
        
        //setting the placeholder text. pretty obviously.
        question.text = placeHolderText
        
        
        if shabbosWarning == false {

        //getting the day of the week to test against Shabbos
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let stringDate: String = formatter.stringFromDate(NSDate())

        //testing shabbos
        if stringDate == "Saturday" {
            
            showAlertController()
            }
        }
        
        shabbosWarning = true
    }
    
    
    
    //setting the placeholder text when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(files.count)
        
        shabbosWarning = false
        
        counter = 0
        
        
        
        //iAd close button stuff here. not sure why though. why did i do it this way?
        closeButton.frame = CGRectMake(10, 30, 40, 40)
        closeButton.layer.cornerRadius = 20
        closeButton.setTitle("X", forState: .Normal)
        closeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        closeButton.backgroundColor = UIColor.whiteColor()
        closeButton.layer.borderColor = UIColor.blackColor().CGColor
        closeButton.layer.borderWidth = 1
        closeButton.addTarget(self, action: "close:", forControlEvents: UIControlEvents.TouchDown)
    
        
        //needed for manipulating the textView. also don't forget the delegate at the top on the class UITextViewDelegate
        question.delegate = self
        //self.question.delegate = self
        
        //setting the placeholder text. pretty obviously.
        question.text = placeHolderText

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //close button for the iAd here
    func close(sender: UIButton) {
        closeButton.removeFromSuperview()
        interstitialAdView.removeFromSuperview()
    }
   
    
    //another keyboard dismissal here for touches
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    
        self.view.endEditing(true)
        
    }
    
    //have to use this to dismiss keyboard with return key instead of the way that works with UITextField
    
    func textView(textView: UITextView!, shouldChangeTextInRange: NSRange, replacementText: NSString!) -> Bool {
        if(replacementText == "\n") {
            textView.resignFirstResponder()
            
        return false
            
        }
        
        return true
    }
    
    //checking the textView text and setting it to empty when editing begins
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {

        
        if(self.question.text == placeHolderText) {
            self.question.text = ""
        }
        
        return true
    }
    


    
    func loadInterstitialAd() {
        

        interstitialAd = ADInterstitialAd()
        interstitialAd.delegate = self
    }
    
    func interstitialAdWillLoad(interstitialAd: ADInterstitialAd!) {
        
    }
    
    func interstitialAdDidLoad(interstitialAd: ADInterstitialAd!) {
        
        question.resignFirstResponder()
        interstitialAdView = UIView()
        interstitialAdView.frame = self.view.bounds
        view.addSubview(interstitialAdView)
        
        
        interstitialAd.presentInView(interstitialAdView)
        UIViewController.prepareInterstitialAds()
        interstitialAdView.addSubview(closeButton)
    }
    
    func interstitialAdActionDidFinish(interstitialAd: ADInterstitialAd!) {
        interstitialAdView.removeFromSuperview()
    }
    
    func interstitialAdActionShouldBegin(interstitialAd: ADInterstitialAd!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func interstitialAd(interstitialAd: ADInterstitialAd!, didFailWithError error: NSError!) {
        
        closeButton.removeFromSuperview()
        interstitialAdView.removeFromSuperview()
    }
    
    func interstitialAdDidUnload(interstitialAd: ADInterstitialAd!) {
        interstitialAdView.removeFromSuperview()
    }


}
