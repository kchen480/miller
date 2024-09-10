import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormTextField extends StatelessWidget {
  final String topic;
  final String warningText;
  final bool isPasswordField;
  final void Function(String text) onSaved;

  FormTextField({
    super.key,
    this.topic = "",
    this.warningText = "",
    this.isPasswordField = false,
    required this.onSaved,
  });

  final String _defaultErrStr = 'Please enter a correct value';
  final Rx<Color> _eyeColor = (Colors.grey).obs;
  late final RxBool _isObscure;

  @override
  Widget build(BuildContext context) {
    _isObscure = isPasswordField.obs;

    return Obx(() => TextFormField(
          obscureText: _isObscure.value,
          decoration: InputDecoration(
            labelText: topic,
            suffixIcon: isPasswordField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _eyeColor.value,
                    ),
                    onPressed: () {
                      _isObscure.value = !_isObscure.value;
                      // eyeColor.value = (isObscure.value
                      //     ? Colors.grey
                      //     : Theme.of(context).iconTheme.color)!;
                    },
                  )
                : null,
          ),
          validator: (v) {
            if (isPasswordField) {
              if (v!.isEmpty) {
                return 'Please enter password';
              }
            } else {
              var emailReg = RegExp(
                  r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
              if (!emailReg.hasMatch(v!)) {
                return warningText.isEmpty ? _defaultErrStr : warningText;
              }
            }
            return null;
          },
          onSaved: (v) => onSaved(v ?? ""),
        ));
  }
}
