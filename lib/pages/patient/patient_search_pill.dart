import 'package:ceehacks/services/database.dart';
import 'package:ceehacks/services/functions.dart';
import 'package:flutter/material.dart';

class PatientSearchPill extends StatefulWidget {
  @override
  _PatientSearchPillState createState() => _PatientSearchPillState();
}

class _PatientSearchPillState extends State<PatientSearchPill> {
  TextEditingController editingController = TextEditingController();

  var items = List<Map<String, dynamic>>();

  loadData() async {
    setState(() {
      items = [];
    });
    if (editingController.value.text.length > 3) {
      var data = await Functions()
          .getDrugs(editingController.value.text.toString().toUpperCase());
      setState(() {
        items.addAll(data.map((e) => e));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search pill'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onEditingComplete: () {
                  loadData();
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: "Search pill",
                  hintText: "Search pill",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      await Database()
                          .addPillToUser(items[index]['lp_nazev_reg']);
                      Navigator.pop(context);
                    },
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(
                        '${items[index]['lp_nazev_reg']} ${items[index]['lp_baleni']}'),
                    subtitle: Text('${items[index]['vpois_nazev']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
