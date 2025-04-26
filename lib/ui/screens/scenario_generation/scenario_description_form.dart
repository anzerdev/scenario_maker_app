import 'package:flutter/material.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/components/scenario_description_text_field.dart';

class ScenarioDescriptionForm extends StatelessWidget {
  const ScenarioDescriptionForm({
    super.key,
    required this.formKey,
    required this.videoThemeController,
    required this.targetAudienceController,
    required this.videoLengthController,
    required this.contentStyleController,
    required this.callToActionController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController videoThemeController;
  final TextEditingController targetAudienceController;
  final TextEditingController videoLengthController;
  final TextEditingController contentStyleController;
  final TextEditingController callToActionController;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ScenarioDescriptionTextField(
                  title: 'Enter the theme of the video \n(e.g., Travel, Food)',
                  hintText: 'Video theme',
                  controller: videoThemeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a video theme';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 16),
                ScenarioDescriptionTextField(
                  title: 'Enter the target audience \n(e.g., Teenagers, Professionals)',
                  hintText: 'Target audience',
                  controller: targetAudienceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the target audience';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 16),
                ScenarioDescriptionTextField(
                  title: 'Enter the length of the video in seconds \n(e.g., 15, 30, 60)',
                  hintText: 'Video length',
                  controller: videoLengthController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a video length';
                    }
            
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 16),
                ScenarioDescriptionTextField(
                  title: 'Enter the style of content \n(e.g., Informative, Humorous)',
                  hintText: 'Content style',
                  controller: contentStyleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a content style';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 16),
                ScenarioDescriptionTextField(
                  title: 'Enter a call to action \n(e.g., Subscribe, Comment)',
                  hintText: 'Call to action',
                  controller: callToActionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a call to action';
                    }
                    return null;
                  }
                ),
              ],
            ),
          ),
        );
  }
}