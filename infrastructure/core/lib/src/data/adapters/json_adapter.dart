import 'dart:convert';

String encodeJson(object) => json.encode(object);
T decodeJson<T>(String encodedModel) => json.decode(encodedModel);