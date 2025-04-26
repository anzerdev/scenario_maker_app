import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:scenario_maker_app/redux/actions.dart';
import 'package:scenario_maker_app/redux/state.dart';
import 'package:scenario_maker_app/services/dio_client.dart';
import 'package:scenario_maker_app/services/firebase_storage.dart';
import 'package:scenario_maker_app/services/helpers.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/components/stub.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/scenario_description_form.dart';

class ScenarioGenerationScreen extends StatefulWidget {
 const ScenarioGenerationScreen({
  required this.socialPlatform, 
  super.key,
  });

 final SocialPlatform socialPlatform;

  @override
  State<ScenarioGenerationScreen> createState() => _ScenarioGenerationScreenState();
}

class _ScenarioGenerationScreenState extends State<ScenarioGenerationScreen> {
  final videoThemeController = TextEditingController();
  final targetAudienceController = TextEditingController();
  final videoLengthController = TextEditingController();
  final contentStyleController = TextEditingController();
  final callToActionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final client = DioClient.instance;

  @override
  void dispose() {
    super.dispose();
    videoThemeController.dispose();
    targetAudienceController.dispose();
    videoLengthController.dispose();
    contentStyleController.dispose();
    callToActionController.dispose();
  }

  void loadScenario(Store store) async {
    if (formKey.currentState!.validate()) {
      try {
        store.dispatch(LoadScenarioAction());
        final res = await getScenario(
          socialPlatform: widget.socialPlatform,
          videoTheme: videoThemeController.text,
          targetAudience: targetAudienceController.text,
          videoLength: videoLengthController.text,
          contentStyle: contentStyleController.text,
          callToAction: callToActionController.text,
          client: client,
        );
        await FirebaseStorage().saveScenario(res);
        store.dispatch(LoadScenarioSuccessAction());
      } catch (error) {
        store.dispatch(LoadScenarioFailureAction(error.toString()));
      }
    }
  }
      
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<ScenarioState>(context);
    return Scaffold(
      appBar: AppBar(
            title: const Text('Generate new video scenario'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StoreConnector<ScenarioState, ScenarioState>( 
              converter: (store) => store.state,
              builder: (context, state) {         
                if (state.loadingStatus == LoadingStatus.defaultStatus ||
                    state.loadingStatus == LoadingStatus.success) {
                  return Column(
                    children: [
                      Expanded(
                        child: ScenarioDescriptionForm(
                          formKey: formKey,
                          videoThemeController: videoThemeController, 
                          targetAudienceController: targetAudienceController, 
                          videoLengthController: videoLengthController, 
                          contentStyleController: contentStyleController, 
                          callToActionController: callToActionController,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => loadScenario(store),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 60,
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  );
                }
                if (state.loadingStatus == LoadingStatus.failure) {
                  return Center(
                    child: Stub(
                      text: 'An error occured!\nTry again later',
                      icon: Icons.warning,
                      iconColor: Colors.red[800],
                    )
                  ); 
                }
                  
                return const Center(
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                  ),
                );
              }),
        ),
      ),
    );}
}