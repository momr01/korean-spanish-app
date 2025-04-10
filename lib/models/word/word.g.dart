part of 'word.dart';

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      id: json['_id'] == null ? null : json['_id'] as String,
      spanish: json['spanish'] as String,
      korean: json['korean'] as String,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      '_id': instance.id?.toString(),
      'spanish': instance.spanish,
      'korean': instance.korean,
    };
