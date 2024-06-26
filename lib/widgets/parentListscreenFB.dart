import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/models/fireBaseModels/parentfb.dart';
import '../core/services/firebaseservices/parent_database_service.dart';

class ParentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent List'),
      ),
      body: StreamBuilder<QuerySnapshot<ParentFB>>(
        stream: ParentDatabaseService().getParents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Data is ready
          final parents = snapshot.data!.docs.map((doc) => doc.data()).toList();

          return ListView.builder(
            itemCount: parents.length,
            itemBuilder: (context, index) {
              final parent = parents[index] as ParentFB;
              return ListTile(
                title: Text('${parent.fname} ${parent.lname}'),
                subtitle: Text('Email: ${parent.email}'),
                onTap: () {
                  // Handle onTap if needed
                },
              );
            },
          );
        },
      ),
    );
  }
}
