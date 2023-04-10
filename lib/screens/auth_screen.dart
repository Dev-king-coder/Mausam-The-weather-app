import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/sign_in_button.dart';
import '../utils/firebase_initialise.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> urLauncher() async {
      const url =
          'https://www.google.com/search?q=monkeys+wedding&sxsrf=APwXEdea0knqbS6G3I6mI-KjucYAuO3-fQ%3A1681092893000&ei=HHEzZOfZPJuMseMPqJywqAs&oq=monkeys+w&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAxgAMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUILhCABDIFCAAQgAQyBQgAEIAEMgUIABCABDoGCLMBEIUEOhMILhCPARDqAhC0AhCMAxDlAhgBOhMIABCPARDqAhC0AhCMAxDlAhgBOgoILhCKBRBDEOoEOgcIABCKBRBDOgsIABCABBCxAxCDAToRCC4QgAQQsQMQgwEQxwEQ0QM6CgguEIoFENQCEEM6DQgAEIoFELEDEIMBEEM6CAgAEIAEELEDOgsILhCABBCxAxCDAToOCC4QgAQQsQMQgwEQ1AI6EAguEIoFELEDEIMBENQCEEM6EQguEIAEELEDEIMBEMcBEK8BOgoILhCABBDUAhAKOgcILhCKBRBDSgQIQRgAUOsCWIYjYM0waAJwAXgBgAGEC4gB1iKSAQsyLTMuNS4xLjctMZgBAKABAbABC8ABAdoBBAgBGAo&sclient=gws-wiz-serp';
      final uri = Uri.parse(url);
      try {
        await launchUrl(uri);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch url,Something went wrong'),
          ),
        );
      }
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  InkWell(
                    onTap: urLauncher,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'lib/assets/images/theme.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ShaderMask(
                    shaderCallback: (rect) {
                      return const RadialGradient(
                        radius: 1.7,
                        colors: <Color>[Colors.yellowAccent, Colors.blue],
                        tileMode: TileMode.mirror,
                      ).createShader(rect);
                    },
                    child: const Text(
                      'Mausam',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder(
                future: FirebaseInitialise.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const SignInButton();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
