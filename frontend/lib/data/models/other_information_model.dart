// To parse this JSON data, do
//
//     final otherInformationModel = otherInformationModelFromJson(jsonString);

import 'dart:convert';

OtherInformationModel otherInformationModelFromJson(String str) => OtherInformationModel.fromJson(json.decode(str));

String otherInformationModelToJson(OtherInformationModel data) => json.encode(data.toJson());

class OtherInformationModel {
    final bool? willingToTravelOutsideResidingLocation;
    final bool? willingToRelocateOutsideResidingLocation;
    final bool? haveTwoWheelerDrivingLicense;
    final bool? havefourWheelerDrivingLicense;
    final bool? ownTwoWheelerVehicle;
    final bool? ownFourWheelerVehicle;

    OtherInformationModel({
        this.willingToTravelOutsideResidingLocation,
        this.willingToRelocateOutsideResidingLocation,
        this.haveTwoWheelerDrivingLicense,
        this.havefourWheelerDrivingLicense,
        this.ownTwoWheelerVehicle,
        this.ownFourWheelerVehicle,
    });

    factory OtherInformationModel.fromJson(Map<String, dynamic> json) => OtherInformationModel(
        willingToTravelOutsideResidingLocation: json["willingToTravelOutsideResidingLocation"],
        willingToRelocateOutsideResidingLocation: json["willingToRelocateOutsideResidingLocation"],
        haveTwoWheelerDrivingLicense: json["haveTwoWheelerDrivingLicense"],
        havefourWheelerDrivingLicense: json["havefourWheelerDrivingLicense"],
        ownTwoWheelerVehicle: json["ownTwoWheelerVehicle"],
        ownFourWheelerVehicle: json["ownFourWheelerVehicle"],
    );

    Map<String, dynamic> toJson() => {
        "willingToTravelOutsideResidingLocation": willingToTravelOutsideResidingLocation,
        "willingToRelocateOutsideResidingLocation": willingToRelocateOutsideResidingLocation,
        "haveTwoWheelerDrivingLicense": haveTwoWheelerDrivingLicense,
        "havefourWheelerDrivingLicense": havefourWheelerDrivingLicense,
        "ownTwoWheelerVehicle": ownTwoWheelerVehicle,
        "ownFourWheelerVehicle": ownFourWheelerVehicle,
    };
}
