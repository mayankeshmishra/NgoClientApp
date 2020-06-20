import 'package:flutter/material.dart';
import './authentication.dart';
import 'package:donations/helpers/constants.dart';
import '../ui_components/bottom_app_bar.dart';
import 'package:donations/helpers/clip_path.dart';
import '../ui_components/donated_amount_card.dart';
import '../ui_components/monthly_donations.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.auth, this.onSignedOut});
  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ClipPathClass clip = ClipPathClass();
  BottomAppBarClass appBar = BottomAppBarClass();
  DonatedAmountCard card = DonatedAmountCard();
  MonthlyDonations tile = MonthlyDonations();

  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print("Error= " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: appBar.getAppBar(context: context),
      body: Container(
        decoration: gradient,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Column(
                  children: [
                    clip.createClipPath(
                        height: deviceHeight / 2 - 60, width: deviceWidth),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Total Donations Made",
                        style: profilePageDonationTextHeadingStyle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: card.getCard(
                                amount: '150', amountType: "Through-Ads"),
                          ),
                          Expanded(
                            child: card.getCard(
                                amount: 1000, amountType: 'Self-Donated'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        decoration: profilePageLoginButtonGradient,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: tile.getListTile(amount: "150")),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal:16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: <Widget>[

                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 190,
              left: MediaQuery.of(context).size.width / 2 - 80,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/myimage1.jpg"),
                radius: 80,
              ),
            ),
            Positioned(
              top: 90,
              right: 20,
              child: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  size: 40,
                  color: Color(0xFF00695c),
                ),
                onPressed: _logoutUser,
              ),
            )
          ],
        ),
      ),
    );
  }
}
