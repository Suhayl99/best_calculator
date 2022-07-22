// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calcule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculateModelAdapter extends TypeAdapter<CalculateModel> {
  @override
  final int typeId = 1;

  @override
  CalculateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculateModel(
      date: fields[0] as String?,
      caculate: fields[1] as String?,
      result: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalculateModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.caculate)
      ..writeByte(2)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
