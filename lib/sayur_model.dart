class NominatimModel {
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? lat;
  final String? lon;
  final String? category;
  final String? type;
  final int? placeRank;
  final double? importance;
  final String? addressType;
  final String? name;
  final String? displayName;
  final AddressNominatim address;
  final List<dynamic> boundingBox;

  NominatimModel({
    this.placeId = 0,
    this.licence = '',
    this.osmType = '',
    this.osmId = 0,
    this.lat = "0.0",
    this.lon = "0.0",
    this.category = '',
    this.type = '',
    this.placeRank = 0,
    this.importance = 0.0,
    this.addressType = '',
    this.name = '',
    this.displayName = '',
    this.address = const AddressNominatim(),
    this.boundingBox = const [],
  });

  factory NominatimModel.fromJson(Map<String, dynamic> json) {
    return NominatimModel(
      placeId: json['place_id'] ?? 0,
      licence: json['licence'] ?? '',
      osmType: json['osm_type'] ?? '',
      osmId: json['osm_id'] ?? 0,
      lat: json['lat'] ?? "0.0",
      lon: json['lon'] ?? "0.0",
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      placeRank: json['place_rank'] ?? 0,
      importance: json['importance'] ?? 0.0,
      addressType: json['addresstype'] ?? '',
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? '',
      address: AddressNominatim.fromJson(json['address']),
      boundingBox: (json['boundingbox']).map((e) => e).toList(),
    );
  }
}

class AddressNominatim {
  final String? suburb;
  final String? cityDistrict;
  final String? town;
  final String? state;
  final String? iso31662Lvl4;
  final String? region;
  final String? iso31662Lvl3;
  final String? postcode;
  final String? country;
  final String? countryCode;

  const AddressNominatim({
    this.suburb = '',
    this.cityDistrict = '',
    this.town = '',
    this.state = '',
    this.iso31662Lvl4 = '',
    this.region = '',
    this.iso31662Lvl3 = '',
    this.postcode = '',
    this.country = '',
    this.countryCode = '',
  });

  factory AddressNominatim.fromJson(Map<String, dynamic> json) {
    return AddressNominatim(
      suburb: json['suburb'] ?? '',
      cityDistrict: json['city_district'] ?? '',
      town: json['town'] ?? json['city'] ?? json['municipality'] ?? '',
      state: json['state'] ?? '',
      iso31662Lvl4: json['ISO3166-2-lvl4'] ?? '',
      region: json['region'] ?? '',
      iso31662Lvl3: json['ISO3166-2-lvl3'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      countryCode: json['country_code'] ?? '',
    );
  }
}
