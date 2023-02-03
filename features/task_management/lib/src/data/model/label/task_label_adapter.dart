import 'package:flutter/material.dart';

import 'task_label.dart';

List<TaskLabel> adaptMapListToTaskLabels(List<Map<String, dynamic>> maps,)
=> List<TaskLabel>.from(maps.map((e) => adaptMapToTaskLabel(e)));

TaskLabel adaptMapToTaskLabel(Map<String, dynamic> map,) => TaskLabel(
  id: map['id'],
  name: map['name'],
  color: adaptStringToColor(map['color']),
);

Color adaptStringToColor(String color) {
  var opacity = 'FF';
  var colorWithoutOpacity = color;
  if(color.length == 8) {
    opacity = color.substring(6,);
    colorWithoutOpacity = color.substring(0, 6,);
  }

  return Color(int.parse('0x$opacity$colorWithoutOpacity'));
}