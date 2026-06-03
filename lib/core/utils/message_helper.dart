

import 'package:flutter/material.dart';

showMessage( state,context) async {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(state.message)),
  );
}

