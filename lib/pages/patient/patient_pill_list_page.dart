import 'package:flutter/material.dart';

class PatientPillsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Pills'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Card(
            elevation: 6,
            child: ListTile(
              title: Text('Ibalgin'),
              subtitle: Text('Ibuprofen'),
              trailing: IconButton(
                icon: Icon(
                  Icons.info,
                  color: theme.primaryColor,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add a new pill',
        //backgroundColor: theme.primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
