// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveProductModelAdapter extends TypeAdapter<HiveProductModel> {
  @override
  final int typeId = 2;

  @override
  HiveProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveProductModel(
      firstImage: fields[0] as String,
      secondImage: fields[1] as String,
      id: fields[2] as String,
      name: fields[3] as String,
      desc: fields[4] as String,
      price: fields[5] as double,
      isAvailable: fields[6] as bool,
      amount: fields[7] as int,
      oldPrice: fields[8] as double,
      createdAt: fields[9] as String,
      updatedAt: fields[10] as String,
      v: fields[11] as int,
      englishName: fields[12] as String,
      purchaseLimit: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveProductModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.firstImage)
      ..writeByte(1)
      ..write(obj.secondImage)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.desc)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.isAvailable)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.oldPrice)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.v)
      ..writeByte(12)
      ..write(obj.englishName)
      ..writeByte(13)
      ..write(obj.purchaseLimit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
