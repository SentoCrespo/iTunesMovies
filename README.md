iTunesMovies
============

# iTunes Movies (ObjC - iOS8)

This project has been developed for my personal portfolio to show the way I write/organize code.

What does it do?

Pretty "simple". A list of movies [en|es] is fetched from iTunes (top 50) in XML, shows them in a pretty way with master-detail pattern. The reason to have chosen XML is because this project was originally written with this specific requirement from a company, but I'd definetly have chosen JSON if I could. In fact there's a section where I explain how to extend this and change it a little bit further in this document.

### Frameworks used

  * [SDWebImage] -> Async images download + cache. 
  * [AFNetworking] -> Fetch movies, although I wrote another method to not depend on it.
  * [Magical record] -> Core Data Wrapper
  * [GBVersionTracking] -> Not really using it but I think it's good to have some version control.
  * [Pure Layout] -> Autolayout wrapper
  * [SVProgressHud] -> Same as MBProgressHud, shows progress on a task in a nice way.
 
### XML Parsing + XCTest

I could've used some framework such as TouchXML or WMFeedParser extending it a little bit, but I've preferred to do it by hand using system's framework. This decission has been made to implement testing as well in that part so you can check it out as well.

Regarding testing, further testing could have been done by mocking and stubing HTTP responses or go further with some integration tests but I've decided to keep this simple as it's just a "demo".

### Core Data + Magical Record

It's been architectured in a way that Magical Record could be replaced and it won't affect any other part of the project. I've decided to go with Core Data to improve memory use and not having lots of objects in memory at the same time by implementing a NSFetchedResultsController inside the UICollectionView. This handles just some objects at the same time, and the list could grow without affecting performance.

### Git and GitFlow

I always try to follow GitFlow rules, by having the following branches:
* Master (Releases here)
* Hotfixes (Production fixes that don't get to mix with current development)
* Dev (Current version)

For each feature, a branch is created from Dev and then merged into it.

### Internationalization

The project is available in English and Spanish. The URL changes so data is collected in the device language (or English by default) and the strings have been localized too.

### UI

The UI tries to follow iOS design guidelines and my personal taste: Clean an simple but attractive. Some Visual Effects have been used as well such as blur in the details controller using the cover image to give a nice style.

### Using JSON instead of XML

Using JSON avoids redundancy, traffic data, improves parsing time and its code. To make this change, is as easy as change the url to match JSON instead of XML, and then use the attributeValues in Core Data model to make Magical Record parse everything. That's it!




### Version
1.0

### About me

If you have any question, comment, want to fork this project, ... you can do pretty much anything with it. If you use my personal Helpers/Categories/Models I'll be glad if you just wrote a mention in your project, send me an email or buy me a beer (that would do it :P).

Vicente Crespo Penadés

[LinkedIn] - My LinkedIn profile

[Email] - Send me an email



License
----

MIT


[LinkedIn]:https://www.linkedin.com/profile/view?id=151887513
[Email]:mailto:vicente.crespo.penades@gmail.com

[SDWebImage]:https://github.com/rs/SDWebImage
[AFNetworking]:https://github.com/AFNetworking/AFNetworking
[Magical record]:https://github.com/magicalpanda/MagicalRecord
[GBVersionTracking]:https://github.com/lmirosevic/GBVersionTracking
[Pure Layout]:https://github.com/smileyborg/PureLayout
[SVProgressHud]:https://github.com/TransitApp/SVProgressHUD

