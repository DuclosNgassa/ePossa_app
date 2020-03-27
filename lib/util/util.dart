import 'package:flutter/material.dart';

class Util {
  static fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

/*
  static List<Post> sortPostDescending(List<Post> posts) {
    posts.sort((post1, post2) => post2.updated_at.compareTo(post1.updated_at));

    return posts;
  }
*/

}
