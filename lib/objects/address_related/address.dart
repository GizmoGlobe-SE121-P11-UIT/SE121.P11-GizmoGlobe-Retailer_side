import 'package:gizmoglobe_client/data/database/database.dart';
import 'package:gizmoglobe_client/objects/address_related/district.dart';
import 'package:gizmoglobe_client/objects/address_related/province.dart';
import 'package:gizmoglobe_client/objects/address_related/ward.dart';

class Address {
  String? addressID;
  String customerID;
  String receiverName;
  String receiverPhone;
  Province? province;
  District? district;
  Ward? ward;
  String? street;
  bool hidden;

  Address({
    this.addressID,
    required this.customerID,
    required this.receiverName,
    required this.receiverPhone,
    this.province,
    this.district,
    this.ward,
    this.street,
    this.hidden = false,
  });

  @override
  String toString() {
    return '$receiverName - $receiverPhone'
        '${street != null && street!.isNotEmpty ? ', $street' : ''}'
        '${ward != null &&  ward!.fullNameEn.isNotEmpty ? ', ${ward!.fullNameEn}' : ''}'
        '${district != null && district!.fullNameEn.isNotEmpty ? ', ${district!.fullNameEn}' : ''}'
        '${province != null && province!.fullNameEn.isNotEmpty ? ', ${province!.fullNameEn}' : ''}';
  }

  String firstLine() {
    return '$receiverName - $receiverPhone';
  }

  String secondLine() {
    return '${street != null && street!.isNotEmpty ? '$street, ' : ''}'
        '${ward != null && ward!.fullNameEn.isNotEmpty ? '${ward!.fullNameEn}, ' : ''}'
        '${district != null && district!.fullNameEn.isNotEmpty ? '${district!.fullNameEn}, ' : ''}'
        '${province != null && province!.fullNameEn.isNotEmpty ? province!.fullNameEn : ''}';
  }

  static Address nullAddress = Address(
    customerID: '',
    receiverName: '',
    receiverPhone: '',
  );

  Map<String, dynamic> toMap() {
    return {
      'addressID': addressID,
      'customerID': customerID,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'provinceCode': province?.code,
      'districtCode': district?.code,
      'wardCode': ward?.code,
      'street': street,
      'hidden': hidden,
    };
  }

  static Address fromMap(Map<String, dynamic> map) {
    final province = Database().provinceList.firstWhere((p) => p.code == map['provinceCode'], orElse: () => Province.nullProvince);
    final district = province.districts?.firstWhere((d) => d.code == map['districtCode'], orElse: () => District.nullDistrict) ?? District.nullDistrict;
    final ward = district.wards?.firstWhere((w) => w.code == map['wardCode'], orElse: () => Ward.nullWard) ?? Ward.nullWard;

    return Address(
      addressID: map['addressID'],
      customerID: map['customerID'],
      receiverName: map['receiverName'],
      receiverPhone: map['receiverPhone'],
      province: province,
      district: district,
      ward: ward,
      street: map['street'],
      hidden: map['hidden'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressID': addressID,
      'customerID': customerID,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'provinceCode': province?.code,
      'districtCode': district?.code,
      'wardCode': ward?.code,
      'street': street,
      'hidden': hidden,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    final province = Database().provinceList.firstWhere(
      (p) => p.code == json['provinceCode'], 
      orElse: () => Province.nullProvince,
    );
    
    final district = province.districts?.firstWhere(
      (d) => d.code == json['districtCode'], 
      orElse: () => District.nullDistrict,
    ) ?? District.nullDistrict;
    
    final ward = district.wards?.firstWhere(
      (w) => w.code == json['wardCode'], 
      orElse: () => Ward.nullWard,
    ) ?? Ward.nullWard;

    return Address(
      addressID: json['addressID'] as String?,
      customerID: json['customerID'] as String,
      receiverName: json['receiverName'] as String,
      receiverPhone: json['receiverPhone'] as String,
      province: province,
      district: district,
      ward: ward,
      street: json['street'] as String?,
      hidden: json['hidden'] as bool? ?? false,
    );
  }

  Address copyWith({
    String? addressID,
    String? customerID,
    String? receiverName,
    String? receiverPhone,
    Province? province,
    District? district,
    Ward? ward,
    String? street,
    bool? hidden,
  }) {
    return Address(
      addressID: addressID ?? this.addressID,
      customerID: customerID ?? this.customerID,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      province: province ?? this.province,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      street: street ?? this.street,
      hidden: hidden ?? this.hidden,
    );
  }
}