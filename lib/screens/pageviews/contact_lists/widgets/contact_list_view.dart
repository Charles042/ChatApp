import 'package:chatapp/utils/universal_variables.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/contact.dart';
import 'package:chatapp/models/users.dart';
import 'package:chatapp/resources/authentication_methods.dart';
// import 'package:chatapp/resources/contact_methods.dart';
import 'package:chatapp/screens/chatscreens/chat_screen.dart';
import 'package:chatapp/screens/chatscreens/widgets/cached_image.dart';
import 'package:chatapp/screens/pageviews/contact_lists/widgets/online_dot_indicator.dart';
import 'package:chatapp/widgets/custom_tile.dart';

class ContactListView extends StatelessWidget {
  final Contact contact;
  final AuthenticationMethods _authenticationMethods = AuthenticationMethods();

  ContactListView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users>(
      future: _authenticationMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Users users = snapshot.data;

          return ViewLayout(
            contact: users,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final Users contact;

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Padding(
        padding: EdgeInsets.only(left: 8, top: 0, right: 0, bottom: 0),
        child: Text(
          (contact != null ? contact.name : null) != null ? contact.name : "..",
          style: TextStyle(
              color: UniversalVariables.textColor,
              fontFamily: "Arial",
              fontSize: 19),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(left: 8, top: 0, right: 0, bottom: 0),
        child: null,
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.uid,
            ),
          ],
        ),
      ),
    );
  }
}
