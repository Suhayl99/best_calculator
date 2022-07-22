import 'package:hive/hive.dart';
part 'calcule_model.g.dart';

@HiveType(typeId:1)
class CalculateModel {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? caculate;
  @HiveField(2)
  String? result;
 

  CalculateModel(
      {
      this.date,
      this.caculate,
      this.result,
    });

  CalculateModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    caculate = json['calculate'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['date'] = date;
    data['calculate'] = caculate;
    data['result'] = result;
    return data;
  }
}

