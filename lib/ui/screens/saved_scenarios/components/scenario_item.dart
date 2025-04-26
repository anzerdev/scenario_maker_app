import 'package:flutter/material.dart';
import 'package:scenario_maker_app/models/scenario_result_model.dart';

class ScenarioItem extends StatefulWidget {
  const ScenarioItem({
    required this.scenario, 
    this.onShare, 
    this.onDelete,
    super.key,});

  final ScenarioResultModel scenario;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;


  @override
  State<ScenarioItem> createState() => _ScenarioItemState();
}
class _ScenarioItemState extends State<ScenarioItem> { 
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.scenario.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: Text(
                widget.scenario.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),   
              secondChild: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.scenario.body,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[600],
                    thickness: 0.8,
                  ),
                  const SizedBox(height: 8),
                 _buildDetailRow(
                      'Platform:', widget.scenario.request.platform.name),
                  _buildDetailRow('Theme:', widget.scenario.request.videoTheme),
                  _buildDetailRow('Target Auidience:',
                      widget.scenario.request.targetAudience),
                  _buildDetailRow(
                      'Call to Action:', widget.scenario.request.callToAction),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: widget.onShare,
                        icon: const Icon(
                          Icons.share,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  )
                ],
                ), 
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst, 
              duration: const Duration(milliseconds: 200),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) { // Removed const
   return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              ' $value',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
