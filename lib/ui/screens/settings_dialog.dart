import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaartha/data/providers/list_providers.dart';
import 'package:vaartha/data/providers/news_provider.dart';

class SettingsScreenDialog extends StatelessWidget {
  const SettingsScreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final itemList = Provider.of<ItemList>(context);
    final loadOption = Provider.of<OptionProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        loadOption.loadCategory();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 244, 212),
          foregroundColor: Colors.black,
          title: const Text("Settings"),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.black12,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Set Priority',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                itemList.isLoading
                    ? const CircularProgressIndicator()
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            for (int i = 0; i < 3; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        (i + 1).toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    DraggableContainer(
                                        index: i, itemList: itemList),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                const SizedBox(height: 16),
                const Text("Hold and drop to set priority"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    loadOption.loadCategory();
                    Navigator.pop(context);
                    // Close the dialog
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DraggableContainer extends StatelessWidget {
  final int index;
  final ItemList itemList;

  const DraggableContainer(
      {super.key, required this.index, required this.itemList});

  @override
  Widget build(BuildContext context) {
    final String itemText = itemList.items[index];

    return Draggable<String>(
      axis: Axis.vertical,
      data: itemText,
      feedback: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 234, 191).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.0)),
        height: 50,
        width: 100,
        child: Center(
            child: Text(
          itemText,
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black.withOpacity(0.5),
            fontSize: 16.0,
          ),
        )),
      ),
      childWhenDragging: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 234, 191).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.0)),
        height: 50,
        width: 100,
        child: DottedBorder(
          radius: const Radius.circular(20.0),
          borderType: BorderType.RRect,
          dashPattern: const [6, 4],
          child: Center(
              child: Text(
            itemText,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black.withOpacity(0.5),
              fontSize: 16.0,
            ),
          )),
        ),
      ),
      child: DragTarget<String>(
        builder: (BuildContext context, List<String?> acceptedData,
            List<dynamic> rejectedData) {
          return Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 234, 191),
                borderRadius: BorderRadius.circular(20.0)),
            height: 50,
            width: 100,
            child: Center(
                child: Text(
              itemText,
              style: const TextStyle(fontSize: 16.0),
            )),
          );
        },
        onAccept: (data) {
          final sourceIndex = index;
          final targetIndex = itemList.items.indexOf(data);
          itemList.swapItems(sourceIndex, targetIndex);
        },
      ),
    );
  }
}
