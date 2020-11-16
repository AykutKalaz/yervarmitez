import 'package:flutter/material.dart';
import 'package:yervarmitez/components/textFieldContainer.dart';

import '../constants.dart';

class RoundedParolaField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedParolaField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: "Parola",
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.visibility,
              color: kPrimaryLightColor,
            )),
      ),
    );
  }
}
