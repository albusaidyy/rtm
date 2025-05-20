import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';

// class AuthenticatedUserAdapter extends TypeAdapter<AuthenticatedUser> {
//   @override
//   final typeId = 0;

//   @override
//   AuthenticatedUser read(BinaryReader reader) {
//     return AuthenticatedUser.fromJson(
//       Map<String, dynamic>.of(
//         json.decode(reader.read() as String) as Map<String, dynamic>,
//       ),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, AuthenticatedUser obj) {
//     writer.write(json.encode(obj.toJson()));
//   }
// }

class VisitAdapter extends TypeAdapter<Visit> {
  @override
  final typeId = 1;

  @override
  Visit read(BinaryReader reader) {
    return Visit.fromJson(
      json.decode(reader.read() as String) as Map<String, dynamic>,
    );
  }

  @override
  void write(BinaryWriter writer, Visit obj) {
    writer.write(json.encode(obj.toJson()));
  }
}

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final typeId = 2;

  @override
  Customer read(BinaryReader reader) {
    return Customer.fromJson(
      json.decode(reader.read() as String) as Map<String, dynamic>,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {}
}

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final typeId = 3;

  @override
  Activity read(BinaryReader reader) {
    return Activity.fromJson(
      json.decode(reader.read() as String) as Map<String, dynamic>,
    );
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer.write(json.encode(obj.toJson()));
  }
}
