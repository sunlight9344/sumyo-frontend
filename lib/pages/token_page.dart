import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2/providers/token_provider.dart';

class TokenPage extends StatefulWidget {
  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  @override
  void initState() {
    super.initState();
    // Call fetchToken() in initState
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await Provider.of<TokenProvider>(context, listen: false).fetchToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Token Page"),
      ),
      body: Consumer<TokenProvider>(
        builder: (context, tokenProvider, child) {
          return Center(
            child: tokenProvider.token != null
                ? Text('Token: ${tokenProvider.token}')
                : CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
