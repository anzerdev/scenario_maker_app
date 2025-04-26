import 'package:flutter/material.dart';
import 'package:scenario_maker_app/models/scenario_result_model.dart';
import 'package:scenario_maker_app/services/auth.dart';
import 'package:scenario_maker_app/services/firebase_storage.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/components/scenario_item.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/components/stub.dart';
import 'package:share_plus/share_plus.dart';

class  SavedScenariosScreen extends StatefulWidget {
 const  SavedScenariosScreen({super.key}) ;

  @override
  State<SavedScenariosScreen> createState() => _SavedScenariosScreenState();
}

class _SavedScenariosScreenState extends State<SavedScenariosScreen> with AutomaticKeepAliveClientMixin<SavedScenariosScreen> {
  @override
  bool get wantKeepAlive => true;
 @override
 Widget build(BuildContext context) {
  super.build(context);
   return Scaffold(
      appBar: AppBar(
        title: const Text('Saved scenarios'),
        actions: [
          IconButton(
            onPressed: () {
              Auth().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<ScenarioResultModel>>(
	      stream: FirebaseStorage().getScenariosStream(),
	      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
	          child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
	          return Stub(
              text: 'Error: ${snapshot.error}', //текст
              icon: Icons.warning, // иконка предупреждения
              iconColor: Colors.red[800], // цвет иконки
            );
		      } else if (snapshot.hasData && snapshot.data != null) {
            final scenarios = snapshot.data!;
            if (scenarios.isEmpty) {
              return Stub(
                text: 'No saved scenarios \nGenerate new scenario', // текст 
                icon: Icons.dangerous, // иконка
                iconColor: Colors.yellow[800], // цвет иконки
              );
				    }			
			      return ListView.builder(
				    itemCount: scenarios.length, // сколько сценариев получили
        		itemBuilder: (context, index) {
	        	  final scenario = scenarios[index];
          		return ScenarioItem(
                scenario: scenario,
                onDelete: () => FirebaseStorage().deleteScenario(scenario.id),
                onShare: () => Share.share(scenario.body),);
        		},
			      );
          } else {
            return Stub(
              text: 'No data available', // текст
              icon: Icons.dangerous, // иконка
              iconColor: Colors.red[800], // цвет иконки
            );
          }
      }),
    );
  }
}