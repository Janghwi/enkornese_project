import 'package:flutter/material.dart';
import 'package:google_sheets_update_example/model/user.dart';

import 'button_widget.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    this.user,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerCatID;
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerUrl;
  late TextEditingController controllerSelection;
  late TextEditingController controllerSelection1;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {
    final catid = widget.user == null ? '' : widget.user!.catid;
    final name = widget.user == null ? '' : widget.user!.name;
    final email = widget.user == null ? '' : widget.user!.email;
    final url = widget.user == null ? '' : widget.user!.url;
    final selection = widget.user == null ? '' : widget.user!.selection;
    final selection1 = widget.user == null ? '' : widget.user!.selection1;

    setState(() {
      controllerCatID = TextEditingController(text: catid);
      controllerName = TextEditingController(text: name);
      controllerEmail = TextEditingController(text: email);
      controllerUrl = TextEditingController(text: url);
      controllerSelection = TextEditingController(text: selection);
      controllerSelection1 = TextEditingController(text: selection1);
    });
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(height: 16),
            buildEmail(),
            const SizedBox(height: 16),
            buildUrl(),
            const SizedBox(height: 16),
            buildSubmit(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && !value.contains('@') ? 'Enter Email' : null,
      );
  Widget buildUrl() => TextFormField(
        controller: controllerUrl,
        decoration: InputDecoration(
          labelText: 'Url',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Url' : null,
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final id = widget.user == null ? null : widget.user!.id;
            final user = User(
              id: id,
              catid: controllerCatID.text,
              name: controllerName.text,
              email: controllerEmail.text,
              url: controllerUrl.text,
              selection: controllerSelection.text,
              selection1: controllerSelection1.text,
            );
            widget.onSavedUser(user);
          }
        },
      );
}
