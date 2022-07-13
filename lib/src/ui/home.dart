import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:maillerapp/src/model/email_history_response.dart';

import '../service/api_class.dart';
import 'create_mail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  onInit() {
    super.initState();
    getHistory();
  }

  EmailHistoryResponse? _emailHistoryResponse;

  bool isLoading = false;
  final _service = ApiClass();

  getHistory() async {
    _emailHistoryResponse = await _service.history();
    return _emailHistoryResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Transform.rotate(angle: 10 * math.pi, child: Icon(Icons.send)),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateMailScreen())),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Mailer"),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data as EmailHistoryResponse;
              return ListView.builder(
                  itemCount: data.rows.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      maintainState: false,
                      // iconColor: appColor,
                      title: ListTile(
                        title: Text(data.rows[index].id),
                        leading: Text("${index + 1}"),
                      ),
                      children: [
                        Text(data.rows[index].templateParams!
                            .replaceAll("{", "")
                            .replaceAll("}", "")
                            .replaceAll("\"", "")
                            .replaceAll(",", "\n")),
                      ],
                    );
                  });
            } else {
              const Center(
                child: Text(
                  "You Haven't sent any mail",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return const Center(child: CircularProgressIndicator());
        },
        future: getHistory(),
      ),
    );
  }
}
