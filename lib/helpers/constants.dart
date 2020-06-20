import 'package:flutter/material.dart';

const gradient=BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white,
              Color(0xff64ffda),
              Color(0xff1de9b6),
            ],
          ),
        );
const profilePageLoginButtonGradient=const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF004d40),
                            Color(0xFF00695c),
                            Color(0xFF00796b),
                            Color(0xFF00897b),
                            Color(0xFF009688),
                            Color(0xFF26a69a),
                            Color(0xFF4db6ac),
                          ],
                        ),
                      );
const profilePageDonationTextHeadingStyle=TextStyle(
                            color: Color(0xFF00695c),
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                            );

var signupButtonBoxDecoration=BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 3,
                          color: Color(0xFF00bfa5),
                        ),
                      );
const signupButtonTextStyle=TextStyle(
                              fontSize: 20,
                              color: Color(0xFF00695c),
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold
                              );