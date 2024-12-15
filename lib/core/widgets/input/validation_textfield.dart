import 'package:flutter/material.dart';

class ValidationTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? onChanged;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  ValidationTextField({
    super.key,
    this.validator,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.icon,
    TextEditingController? controller,
  }) : controller = controller ?? TextEditingController();

  @override
  ValidationTextFieldState createState() => ValidationTextFieldState();

  String get text => controller.text;

}

class ValidationTextFieldState extends State<ValidationTextField> {
  String? errorText;

  get text => widget.controller.text;

  void validate() {
    setState(() {
      errorText = widget.validator!(widget.controller.text);
    });
  }

  bool isValid() {
    //validate the field
    validate();
    return errorText == null;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        icon: widget.icon != null ? Icon(widget.icon) : null,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: (value) {
        if (widget.validator != null) {
          setState(() {
            errorText = widget.validator!(value);
          });
        }

        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}