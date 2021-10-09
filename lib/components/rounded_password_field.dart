import 'package:flutter/material.dart';
import 'package:flutter_a1/components/text_field_container.dart';
import 'package:flutter_a1/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const RoundedPasswordField({Key key, this.onChanged, this.hintText}) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _visibility;

  @override
  void initState(){
    _visibility= true;
  }

  void _toggle() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _visibility,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText!=null ? '${widget.hintText}' : 'Password',
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon : Icon(
            _visibility ? Icons.visibility : Icons.visibility_off,
            color: kPrimaryColor,
            ),
            onPressed: (){
              _toggle();
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
