import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  List<Province> provinces =
      nepalAdministrativeDivisions; // Populate this with actual data
  Province? selectedProvince;
  District? selectedDistrict;
  Municipality? selectedMunicipality;
  String? selectedStreet;

  bool isMinimizedProvince = false;

  void toggleMinimizedProvince() {
    isMinimizedProvince = !isMinimizedProvince;
    notifyListeners();
  }

  bool isMinimizedMunicipality = false;

  void toggleMinimizedMunicipality() {
    isMinimizedMunicipality = !isMinimizedMunicipality;
    notifyListeners();
  }

  bool isMinimizedDistrict = false;

  void toggleMinimizedDistrict() {
    isMinimizedDistrict = !isMinimizedDistrict;
    notifyListeners();
  }

  bool isMinimizedAddress = false;

  void toggleMinimizedAddress() {
    isMinimizedAddress = !isMinimizedAddress;
    notifyListeners();
  }

  void setSelectedProvince(Province? province) {
    selectedProvince = province;
    selectedDistrict = null; // Reset district selection
    selectedMunicipality = null; // Reset municipality selection
    selectedStreet = null; // Reset street selection
    notifyListeners();
  }

  void setSelectedDistrict(District? district) {
    selectedDistrict = district;
    selectedMunicipality = null; // Reset municipality selection
    selectedStreet = null; // Reset street selection
    notifyListeners();
  }

  void setSelectedMunicipality(Municipality? municipality) {
    selectedMunicipality = municipality;
    selectedStreet = null; // Reset street selection
    notifyListeners();
  }

  void setSelectedStreet(String? street) {
    selectedStreet = street;
    notifyListeners();
  }

  void reset() {
    selectedProvince = null;
    selectedDistrict = null;
    selectedMunicipality = null;
    selectedStreet = null;
    notifyListeners();
  }
}

class Province {
  final String name;
  final List<District> districts;

  Province({required this.name, required this.districts});
}

class District {
  final String name;
  final List<Municipality> municipalities;

  District({required this.name, required this.municipalities});
}

class Municipality {
  final String name;
  final List<String> streets;

  Municipality({required this.name, required this.streets});
}

final List<Province> nepalAdministrativeDivisions = [
  // Province No. 1
  Province(name: "Province No. 1", districts: [
    District(name: "Bhojpur", municipalities: [
      Municipality(
          name: "Bhojpur Municipality",
          streets: ["Main Street", "Bazaar Road"]),
      Municipality(
          name: "Shadananda Municipality",
          streets: ["Central Road", "Market Street"]),
    ]),
    District(name: "Dhankuta", municipalities: [
      Municipality(
          name: "Dhankuta Municipality",
          streets: ["Town Center Road", "Bazaar Lane"]),
      Municipality(
          name: "Pakhribas Municipality",
          streets: ["Main Highway", "Community Road"]),
    ]),
    District(name: "Ilam", municipalities: [
      Municipality(
          name: "Ilam Municipality",
          streets: ["Tea Garden Road", "Hill Station Street"]),
      Municipality(
          name: "Deumai Municipality",
          streets: ["River View Road", "Mountain Path"]),
    ]),
    District(name: "Jhapa", municipalities: [
      Municipality(
          name: "Mechinagar Municipality",
          streets: ["Border Road", "Tea Estate Street"]),
      Municipality(
          name: "Damak Municipality",
          streets: ["Main Market Road", "Industrial Area"]),
    ]),
    District(name: "Khotang", municipalities: [
      Municipality(
          name: "Diktel Rupakot Majhuwagadhi Municipality",
          streets: ["Central Road", "Hill View Street"]),
      Municipality(
          name: "Halesi Tuwachung Municipality",
          streets: ["Temple Road", "Cave Path"]),
    ]),
    District(name: "Morang", municipalities: [
      Municipality(
          name: "Biratnagar Metropolitan City",
          streets: ["Main Road", "Industrial Area"]),
      Municipality(
          name: "Sundarharaicha Municipality",
          streets: ["Town Center", "Market Street"]),
    ]),
    District(name: "Okhaldhunga", municipalities: [
      Municipality(
          name: "Siddhicharan Municipality",
          streets: ["Mountain View Road", "Bazaar Street"]),
      Municipality(
          name: "Manebhanjyang Rural Municipality",
          streets: ["Village Path", "Community Road"]),
    ]),
    District(name: "Panchthar", municipalities: [
      Municipality(
          name: "Phidim Municipality",
          streets: ["Town Center", "Tea Garden Road"]),
      Municipality(
          name: "Hilihang Rural Municipality",
          streets: ["Mountain Trail", "Village Street"]),
    ]),
    District(name: "Sankhuwasabha", municipalities: [
      Municipality(
          name: "Chainpur Municipality",
          streets: ["River View Road", "Mountain Path"]),
      Municipality(
          name: "Khandbari Municipality",
          streets: ["Town Center", "Trekking Trail"]),
    ]),
    District(name: "Solukhumbu", municipalities: [
      Municipality(
          name: "Solududhkunda Municipality",
          streets: ["Everest View Road", "Sherpa Village Path"]),
      Municipality(
          name: "Mahakulung Rural Municipality",
          streets: ["Mountain Trail", "Trekking Route"]),
    ]),
    District(name: "Sunsari", municipalities: [
      Municipality(
          name: "Dharan Sub-Metropolitan City",
          streets: ["Main Road", "University Area"]),
      Municipality(
          name: "Itahari Sub-Metropolitan City",
          streets: ["Highway Road", "Market Center"]),
    ]),
    District(name: "Taplejung", municipalities: [
      Municipality(
          name: "Phungling Municipality",
          streets: ["Mountain View Road", "Tea Garden Path"]),
      Municipality(
          name: "Aathrai Triveni Rural Municipality",
          streets: ["River Side", "Village Trail"]),
    ]),
    District(name: "Terhathum", municipalities: [
      Municipality(
          name: "Myanglung Municipality",
          streets: ["Town Center", "Hill Station Road"]),
      Municipality(
          name: "Laligurans Municipality",
          streets: ["Tea Estate Street", "Mountain View Path"]),
    ]),
    District(name: "Udayapur", municipalities: [
      Municipality(
          name: "Triyuga Municipality",
          streets: ["River View Road", "Town Center"]),
      Municipality(
          name: "Katari Municipality",
          streets: ["Highway Street", "Market Area"]),
    ]),
  ]),

  // Province No. 2 (Madhesh Province)
  Province(name: "Madhesh Province", districts: [
    District(name: "Bara", municipalities: [
      Municipality(
          name: "Kalaiya Sub-Metropolitan City",
          streets: ["Main Road", "Market Center"]),
      Municipality(
          name: "Jeetpur Simara Sub-Metropolitan City",
          streets: ["Industrial Area", "Highway Street"]),
    ]),
    District(name: "Dhanusha", municipalities: [
      Municipality(
          name: "Janakpur Sub-Metropolitan City",
          streets: ["Temple Road", "Cultural Center"]),
      Municipality(
          name: "Chhireshwornath Municipality",
          streets: ["River Side", "Market Street"]),
    ]),
    District(name: "Mahottari", municipalities: [
      Municipality(
          name: "Jaleshwar Municipality",
          streets: ["Town Center", "Agricultural Road"]),
      Municipality(
          name: "Bardibas Municipality",
          streets: ["Highway Street", "Market Area"]),
    ]),
    District(name: "Parsa", municipalities: [
      Municipality(
          name: "Birgunj Metropolitan City",
          streets: ["Border Road", "Industrial Area"]),
      Municipality(
          name: "Pokhariya Municipality",
          streets: ["Town Center", "Market Street"]),
    ]),
    District(name: "Rautahat", municipalities: [
      Municipality(
          name: "Gaur Municipality",
          streets: ["Main Road", "Administrative Area"]),
      Municipality(
          name: "Chandrapur Municipality",
          streets: ["Highway Street", "Market Center"]),
    ]),
    District(name: "Saptari", municipalities: [
      Municipality(
          name: "Rajbiraj Municipality",
          streets: ["Town Center", "Cultural Road"]),
      Municipality(
          name: "Kanchanrup Municipality",
          streets: ["River Side", "Market Street"]),
    ]),
    District(name: "Sarlahi", municipalities: [
      Municipality(
          name: "Malangwa Municipality",
          streets: ["Main Road", "Administrative Center"]),
      Municipality(
          name: "Lalbandi Municipality",
          streets: ["Highway Street", "Market Area"]),
    ]),
    District(name: "Siraha", municipalities: [
      Municipality(
          name: "Siraha Municipality", streets: ["Town Center", "Market Road"]),
      Municipality(
          name: "Golbazar Municipality",
          streets: ["Highway Street", "Industrial Area"]),
    ]),
  ]),

  // Bagmati Province
  Province(name: "Bagmati Province", districts: [
    District(name: "Bhaktapur", municipalities: [
      Municipality(
          name: "Bhaktapur Municipality",
          streets: ["Durbar Square", "Pottery Square"]),
      Municipality(
          name: "Madhyapur Thimi Municipality",
          streets: ["Cultural Road", "Market Street"]),
    ]),
    District(name: "Chitwan", municipalities: [
      Municipality(
          name: "Bharatpur Metropolitan City",
          streets: ["Main Road", "Tourist Area"]),
      Municipality(
          name: "Ratnanagar Municipality",
          streets: ["Wildlife Road", "River Side"]),
    ]),
    District(name: "Dhading", municipalities: [
      Municipality(
          name: "Nilkantha Municipality",
          streets: ["Town Center", "Mountain View Road"]),
      Municipality(
          name: "Dhunibesi Municipality",
          streets: ["River Side", "Agricultural Street"]),
    ]),
    District(name: "Dolakha", municipalities: [
      Municipality(
          name: "Bhimeshwar Municipality",
          streets: ["Mountain Road", "Market Center"]),
      Municipality(
          name: "Jiri Municipality",
          streets: ["Trekking Trail", "Town Square"]),
    ]),
    District(name: "Kathmandu", municipalities: [
      Municipality(
          name: "Kathmandu Metropolitan City",
          streets: ["Durbar Square", "Thamel Road"]),
      Municipality(
          name: "Kirtipur Municipality",
          streets: ["University Road", "Ancient Town Street"]),
    ]),
    District(name: "Kavrepalanchok", municipalities: [
      Municipality(
          name: "Dhulikhel Municipality",
          streets: ["Viewpoint Road", "Educational Street"]),
      Municipality(
          name: "Banepa Municipality",
          streets: ["Highway Road", "Market Center"]),
    ]),
    District(name: "Lalitpur", municipalities: [
      Municipality(
          name: "Lalitpur Metropolitan City",
          streets: ["Patan Durbar Square", "Jawalakhel Road"]),
      Municipality(
          name: "Godawari Municipality",
          streets: ["Botanical Garden Road", "Hill Station Street"]),
    ]),
    District(name: "Makwanpur", municipalities: [
      Municipality(
          name: "Hetauda Sub-Metropolitan City",
          streets: ["Industrial Road", "Forest Path"]),
      Municipality(
          name: "Thaha Municipality",
          streets: ["Hill Station Road", "Market Street"]),
    ]),
    District(name: "Nuwakot", municipalities: [
      Municipality(
          name: "Bidur Municipality",
          streets: ["Historical Fort Road", "River View Street"]),
      Municipality(
          name: "Belkotgadhi Municipality",
          streets: ["Mountain Path", "Agricultural Road"]),
    ]),
    District(name: "Ramechhap", municipalities: [
      Municipality(
          name: "Manthali Municipality",
          streets: ["River Side Road", "Market Center"]),
      Municipality(
          name: "Ramechhap Municipality",
          streets: ["Mountain View Street", "Temple Road"]),
    ]),
    District(name: "Rasuwa", municipalities: [
      Municipality(
          name: "Gosaikunda Rural Municipality",
          streets: ["Trekking Trail", "Pilgrimage Path"]),
      Municipality(
          name: "Naukunda Rural Municipality",
          streets: ["Mountain Road", "Border Town Street"]),
    ]),
    District(name: "Sindhuli", municipalities: [
      Municipality(
          name: "Kamalamai Municipality",
          streets: ["Highway Road", "Market Center"]),
      Municipality(
          name: "Dudhauli Municipality",
          streets: ["Historical Path", "Agricultural Street"]),
    ]),
    District(name: "Sindhupalchok", municipalities: [
      Municipality(
          name: "Chautara Sangachokgadhi Municipality",
          streets: ["Mountain View Road", "Market Street"]),
      Municipality(
          name: "Melamchi Municipality",
          streets: ["River Side", "Agricultural Path"]),
    ]),
  ]),

  // Gandaki Province
  Province(name: "Gandaki Province", districts: [
    District(name: "Baglung", municipalities: [
      Municipality(
          name: "Baglung Municipality",
          streets: ["Town Center", "River View Road"]),
      Municipality(
          name: "Galkot Municipality",
          streets: ["Mountain Path", "Market Street"]),
    ]),
    District(name: "Gorkha", municipalities: [
      Municipality(
          name: "Gorkha Municipality",
          streets: ["Historical Fort Road", "Earthquake Memorial Street"]),
      Municipality(
          name: "Palungtar Municipality",
          streets: ["River Side", "Agricultural Path"]),
    ]),
    District(name: "Kaski", municipalities: [
      Municipality(
          name: "Pokhara Metropolitan City",
          streets: ["Lakeside Road", "Mountain View Street"]),
      Municipality(
          name: "Annapurna Rural Municipality",
          streets: ["Trekking Trail", "Village Path"]),
    ]),
    District(name: "Lamjung", municipalities: [
      Municipality(
          name: "Besisahar Municipality",
          streets: ["River View Road", "Trekking Start Point"]),
      Municipality(
          name: "Madhya Nepal Municipality",
          streets: ["Mountain Path", "Agricultural Street"]),
    ]),
    District(name: "Manang", municipalities: [
      Municipality(
          name: "Chame Rural Municipality",
          streets: ["Trekking Trail", "Mountain View Path"]),
      Municipality(
          name: "Narpa Bhumi Rural Municipality",
          streets: ["High Altitude Road", "Buddhist Temple Street"]),
    ]),
    District(name: "Mustang", municipalities: [
      Municipality(
          name: "Gharapjhong Rural Municipality",
          streets: ["Ancient Kingdom Road", "Desert Mountain Path"]),
      Municipality(
          name: "Lo-Ghekar Damodarkunda Rural Municipality",
          streets: ["Pilgrimage Trail", "Trans-Himalayan Route"]),
    ]),
    District(name: "Myagdi", municipalities: [
      Municipality(
          name: "Beni Municipality",
          streets: ["River Confluence Road", "Market Center"]),
      Municipality(
          name: "Annapurna Rural Municipality",
          streets: ["Trekking Path", "Mountain View Street"]),
    ]),
    District(name: "Nawalparasi East", municipalities: [
      Municipality(
          name: "Kawasoti Municipality",
          streets: ["Highway Road", "Industrial Area"]),
      Municipality(
          name: "Madhyabindu Municipality",
          streets: ["River Side", "Agricultural Street"]),
    ]),
    District(name: "Parbat", municipalities: [
      Municipality(
          name: "Kusma Municipality",
          streets: ["River View Road", "Hill Station Street"]),
      Municipality(
          name: "Phalebas Municipality",
          streets: ["Mountain Path", "Market Center"]),
    ]),
    District(name: "Syangja", municipalities: [
      Municipality(
          name: "Putalibazar Municipality",
          streets: ["Town Center", "Educational Street"]),
      Municipality(
          name: "Waling Municipality",
          streets: ["Highway Road", "Market Area"]),
    ]),
    District(name: "Tanahun", municipalities: [
      Municipality(
          name: "Vyas Municipality",
          streets: ["River Side Road", "Historical Center"]),
      Municipality(
          name: "Shuklagandaki Municipality",
          streets: ["Highway Street", "Tourist Area"]),
    ]),
  ]),

  // Lumbini Province
  Province(name: "Lumbini Province", districts: [
    District(name: "Arghakhanchi", municipalities: [
      Municipality(
          name: "Sandhikharka Municipality",
          streets: ["Town Center", "Hill View Road"]),
      Municipality(
          name: "Bhumikasthan Municipality",
          streets: ["Temple Street", "Market Area"]),
    ]),
    District(name: "Banke", municipalities: [
      Municipality(
          name: "Nepalgunj Sub-Metropolitan City",
          streets: ["Border Road", "Market Center"]),
      Municipality(
          name: "Kohalpur Municipality",
          streets: ["Highway Street", "Educational Area"]),
    ]),
    District(name: "Bardiya", municipalities: [
      Municipality(
          name: "Gulariya Municipality",
          streets: ["Wildlife Reserve Road", "Town Center"]),
      Municipality(
          name: "Rajapur Municipality",
          streets: ["River Side", "Agricultural Street"]),
    ]),
    District(name: "Dang", municipalities: [
      Municipality(
          name: "Ghorahi Sub-Metropolitan City",
          streets: ["Main Road", "Industrial Area"]),
      Municipality(
          name: "Tulsipur Sub-Metropolitan City",
          streets: ["Market Center", "Educational Street"]),
    ]),
    District(name: "Gulmi", municipalities: [
      Municipality(
          name: "Resunga Municipality",
          streets: ["Hill Station Road", "Temple Street"]),
      Municipality(
          name: "Musikot Municipality",
          streets: ["Town Center", "Historical Path"]),
    ]),
    District(name: "Kapilvastu", municipalities: [
      Municipality(
          name: "Kapilvastu Municipality",
          streets: ["Buddhist Circuit Road", "Market Area"]),
      Municipality(
          name: "Buddhabhumi Municipality",
          streets: ["Pilgrimage Path", "Agricultural Street"]),
    ]),
    District(name: "Nawalparasi West", municipalities: [
      Municipality(
          name: "Ramgram Municipality",
          streets: ["Buddhist Site Road", "Market Center"]),
      Municipality(
          name: "Sunwal Municipality",
          streets: ["Highway Street", "Industrial Area"]),
    ]),
    District(name: "Palpa", municipalities: [
      Municipality(
          name: "Tansen Municipality",
          streets: ["Hill Station Road", "Durbar Square"]),
      Municipality(
          name: "Rampur Municipality",
          streets: ["Educational Street", "Market Area"]),
    ]),
    District(name: "Pyuthan", municipalities: [
      Municipality(
          name: "Pyuthan Municipality",
          streets: ["Town Center", "River View Road"]),
      Municipality(
          name: "Swargadwari Municipality",
          streets: ["Pilgrimage Path", "Hill Station Street"]),
    ]),
    District(name: "Rolpa", municipalities: [
      Municipality(
          name: "Liwang Municipality",
          streets: ["Town Center", "Historical Path"]),
      Municipality(
          name: "Rolpa Municipality",
          streets: ["Mountain View Road", "Market Street"]),
    ]),
    District(name: "Rupandehi", municipalities: [
      Municipality(
          name: "Butwal Sub-Metropolitan City",
          streets: ["Industrial Road", "Market Center"]),
      Municipality(
          name: "Siddharthanagar Municipality",
          streets: ["Buddhist Circuit Path", "Border Town Street"]),
    ]),
    District(name: "Rukum East", municipalities: [
      Municipality(
          name: "Putha Uttarganga Rural Municipality",
          streets: ["Mountain Trail", "River Side Path"]),
      Municipality(
          name: "Bhume Rural Municipality",
          streets: ["Village Center", "Forest Road"]),
    ]),
  ]),

  // Karnali Province
  Province(name: "Karnali Province", districts: [
    District(name: "Dailekh", municipalities: [
      Municipality(
          name: "Narayan Municipality",
          streets: ["Town Center", "Historical Path"]),
      Municipality(
          name: "Dullu Municipality",
          streets: ["River View Road", "Market Street"]),
    ]),
    District(name: "Dolpa", municipalities: [
      Municipality(
          name: "Thuli Bheri Municipality",
          streets: ["Mountain Trail", "Lake View Path"]),
      Municipality(
          name: "Tripurasundari Municipality",
          streets: ["High Altitude Road", "Buddhist Temple Street"]),
    ]),
    District(name: "Humla", municipalities: [
      Municipality(
          name: "Simkot Rural Municipality",
          streets: ["Mountain Pass Road", "Border Town Path"]),
      Municipality(
          name: "Namkha Rural Municipality",
          streets: ["High Altitude Trail", "Pilgrimage Route"]),
    ]),
    District(name: "Jajarkot", municipalities: [
      Municipality(
          name: "Bheri Municipality",
          streets: ["River Side Road", "Town Center"]),
      Municipality(
          name: "Chhedagad Municipality",
          streets: ["Mountain View Street", "Market Area"]),
    ]),
    District(name: "Jumla", municipalities: [
      Municipality(
          name: "Chandannath Municipality",
          streets: ["Apple Farm Road", "Town Center"]),
      Municipality(
          name: "Kankasundari Rural Municipality",
          streets: ["Mountain Trail", "Lake View Path"]),
    ]),
    District(name: "Kalikot", municipalities: [
      Municipality(
          name: "Khandachakra Municipality",
          streets: ["River View Road", "Market Center"]),
      Municipality(
          name: "Raskot Municipality",
          streets: ["Mountain Path", "Agricultural Street"]),
    ]),
    District(name: "Mugu", municipalities: [
      Municipality(
          name: "Chhayanath Rara Municipality",
          streets: ["Lake Side Road", "Mountain View Path"]),
      Municipality(
          name: "Mugum Karmarong Rural Municipality",
          streets: ["High Altitude Trail", "Border Town Street"]),
    ]),
    District(name: "Rukum West", municipalities: [
      Municipality(
          name: "Musikot Municipality",
          streets: ["Town Center", "River Side Road"]),
      Municipality(
          name: "Chaurjahari Municipality",
          streets: ["Mountain View Street", "Market Area"]),
    ]),
    District(name: "Salyan", municipalities: [
      Municipality(
          name: "Shaarda Municipality",
          streets: ["Town Center", "Historical Path"]),
      Municipality(
          name: "Bangad Kupinde Municipality",
          streets: ["River View Road", "Agricultural Street"]),
    ]),
    District(name: "Surkhet", municipalities: [
      Municipality(
          name: "Birendranagar Municipality",
          streets: ["Main Road", "Market Center"]),
      Municipality(
          name: "Gurbhakot Municipality",
          streets: ["Hill Station Street", "Educational Area"]),
    ]),
  ]),

  // Sudurpashchim Province
  Province(name: "Sudurpashchim Province", districts: [
    District(name: "Achham", municipalities: [
      Municipality(
          name: "Mangalsen Municipality",
          streets: ["Town Center", "Historical Path"]),
      Municipality(
          name: "Kamalbazar Municipality",
          streets: ["River View Road", "Market Street"]),
    ]),
    District(name: "Baitadi", municipalities: [
      Municipality(
          name: "Dasharathchand Municipality",
          streets: ["Town Center", "Temple Road"]),
      Municipality(
          name: "Patan Municipality",
          streets: ["Historical Path", "Market Area"]),
    ]),
    District(name: "Bajhang", municipalities: [
      Municipality(
          name: "Jayaprithvi Municipality",
          streets: ["Mountain View Road", "Town Center"]),
      Municipality(
          name: "Bungal Municipality",
          streets: ["River Side", "Agricultural Street"]),
    ]),
    District(name: "Bajura", municipalities: [
      Municipality(
          name: "Badimalika Municipality",
          streets: ["Mountain Trail", "Town Center"]),
      Municipality(
          name: "Budhiganga Municipality",
          streets: ["River View Road", "Market Street"]),
    ]),
    District(name: "Dadeldhura", municipalities: [
      Municipality(
          name: "Amargadhi Municipality",
          streets: ["Hill Station Road", "Market Center"]),
      Municipality(
          name: "Parshuram Municipality",
          streets: ["Historical Path", "Educational Street"]),
    ]),
    District(name: "Darchula", municipalities: [
      Municipality(
          name: "Mahakali Municipality",
          streets: ["Border Town Road", "River Side Path"]),
      Municipality(
          name: "Shailyashikhar Municipality",
          streets: ["Mountain View Street", "Market Area"]),
    ]),
    District(name: "Doti", municipalities: [
      Municipality(
          name: "Dipayal Silgadhi Municipality",
          streets: ["Town Center", "Historical Path"]),
      Municipality(
          name: "Shikhar Municipality",
          streets: ["Mountain View Road", "Market Street"]),
    ]),
    District(name: "Kailali", municipalities: [
      Municipality(
          name: "Dhangadhi Sub-Metropolitan City",
          streets: ["Main Road", "Market Center"]),
      Municipality(
          name: "Tikapur Municipality",
          streets: ["River Side", "Agricultural Street"]),
    ]),
    District(name: "Kanchanpur", municipalities: [
      Municipality(
          name: "Bhimdatta Municipality",
          streets: ["Border Town Road", "Market Center"]),
      Municipality(
          name: "Bedkot Municipality",
          streets: ["Wildlife Reserve Path", "Agricultural Street"]),
    ]),
  ]),
];
