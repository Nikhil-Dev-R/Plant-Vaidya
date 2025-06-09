import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:plant_vaidya/providers/app_state_provider.dart';
import 'package:plant_vaidya/widgets/plant_analysis_form_widget.dart';
import 'package:plant_vaidya/widgets/analysis_result_widget.dart';
import 'package:plant_vaidya/widgets/plant_information_widget.dart';
import 'package:plant_vaidya/widgets/loading_indicator.dart';
import 'package:plant_vaidya/models/plant_models.dart';
import 'package:mime/mime.dart';

import '../models/plant_ai_models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleFormSubmit(
    BuildContext context,
    XFile imageFile,
    String description,
    AnalysisAction action,
  ) async {
    final appState = Provider.of<AppStateProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);
      final String? mimeType = lookupMimeType(imageFile.path);
      final String dataUri =
          'data:${mimeType ?? 'image/jpeg'};base64,$base64Image';

      await appState.handleSubmit(dataUri, description, imageFile.name, action);

      if (appState.error == null) {
        if (action == AnalysisAction.disease &&
            appState.analysisResult != null) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(appState.analysisResult!.diseaseDetected
                  ? 'Disease Analysis Complete: Detected ${appState.analysisResult!.diseaseName}'
                  : 'Disease Analysis Complete: Plant appears healthy!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (action == AnalysisAction.info &&
            appState.plantInfoResult != null) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(appState.plantInfoResult!.error != null
                  ? appState.plantInfoResult!.error!
                  : !(appState.plantInfoResult!.isPlant)
                      ? "The image does not appear to be a plant."
                      : 'Plant Information Retrieved for ${appState.plantInfoResult!.commonName ?? 'the plant'}'),
              backgroundColor: appState.plantInfoResult!.error != null ||
                      !(appState.plantInfoResult!.isPlant)
                  ? Colors.orange
                  : Colors.green,
            ),
          );
        }
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Error: ${appState.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      // Removed call to appState.setProcessing(false) because setProcessing method was removed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plant Vaidya'),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'History',
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
          ],
        ),
        body: Consumer<AppStateProvider>(
          builder: (context, appState, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PlantAnalysisForm(
                    onSubmit: (XFile imageFile, String description,
                            AnalysisAction action) =>
                        _handleFormSubmit(
                            context, imageFile, description, action),
                    isProcessing: appState.isProcessing,
                  ),
                  if (appState.isProcessing)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: const [
                          LoadingIndicator(),
                          SizedBox(height: 10),
                          Text('AI is thinking, please wait...'),
                        ],
                      ),
                    ),
                  if (appState.error != null && !appState.isProcessing)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        color: Colors.red[100],
                        child: ListTile(
                          leading: Icon(Icons.error, color: Colors.red[700]),
                          title: Text('Error',
                              style: TextStyle(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(appState.error!,
                              style: TextStyle(color: Colors.red[700])),
                        ),
                      ),
                    ),
                  if (appState.analysisResult != null && !appState.isProcessing)
                    AnalysisResultWidget(
                        result: AnalyzePlantDiseaseOutput(
                      diseaseDetected: appState.analysisResult!.diseaseDetected,
                      diseaseName: appState.analysisResult!.diseaseName,
                      suggestedSolutions:
                          appState.analysisResult!.suggestedSolutions,
                    )),
                  if (appState.plantInfoResult != null &&
                      !appState.isProcessing)
                    PlantInformationWidget(
                        info: GetPlantInfoOutput(
                      isPlant: appState.plantInfoResult!.isPlant,
                      commonName: appState.plantInfoResult!.commonName,
                      latinName: appState.plantInfoResult!.latinName,
                      plantDescription:
                          appState.plantInfoResult!.plantDescription,
                      careTips: appState.plantInfoResult!.careTips,
                      funFacts: appState.plantInfoResult!.funFacts,
                      error: appState.plantInfoResult!.error,
                    )),
                ],
              ),
            );
          },
        )
      );
  }
}
