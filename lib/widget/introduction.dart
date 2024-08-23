import 'package:flutter/material.dart';

class Introduction extends StatelessWidget {
  final String title;
  final String? detail;
  final String buttom;
  final Widget page;
  final bool showSigninIcon;

  const Introduction({
    super.key,
    required this.title,
    this.detail,
    required this.buttom,
    required this.page,
    this.showSigninIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(context),
            if (detail != null) _buildDescription(context),
            if (showSigninIcon) _buildSigninIcon(),
            _buildStartButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildDescription(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Text(
        detail!,
        style: theme.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSigninIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 48,
          height: 48,
          color: Colors.white,
          child: Image.asset('asset/image/icon_google.png'),
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: SizedBox(
        width: 120,
        child: Text(
          buttom,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
