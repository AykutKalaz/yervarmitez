import 'package:flutter/material.dart';
import 'package:yervarmitez/components/textFieldContainer.dart';

import '../constants.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType textInputType;
  final String kontrol;
  const RoundedInputField({
    Key key,
    this.textInputType,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.kontrol,
  }) : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  final Kontrolcu = TextEditingController();
  @override
  void initState() {
    Kontrolcu.addListener(() {
      setState(() {});
    });
    Kontrolcu.text = widget.kontrol;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(fontSize: 19),
        controller: Kontrolcu,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: widget.hintText,
            icon: Icon(
              widget.icon,
              color: kPrimaryColor,
            ),
            border: InputBorder.none,
            suffixIcon: Kontrolcu.text.isEmpty
                ? Container(
                    width: 0,
                  )
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Kontrolcu.clear(),
                  )),
      ),
    );
  }
}
