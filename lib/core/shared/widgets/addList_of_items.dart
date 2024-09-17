import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';

class AddListOfItems extends StatefulWidget {
  const AddListOfItems({
    super.key,
    required this.title,
    required this.controller,
    required this.list,
  });
  final String title;
  final TextEditingController controller;
  final List<String> list;

  @override
  State<AddListOfItems> createState() => _AddListOfItemsState();
}

class _AddListOfItemsState extends State<AddListOfItems> {
  void _addItem(List<String> list, TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      setState(() {
        list.add(controller.text);
        controller.clear();
      });
    }
  }

  void _removeItem(List<String> list, String item) {
    setState(() {
      list.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyLarge!.apply(fontSizeDelta: 8),
        ),
        const SizedBox(height: TSizes.spaceBtnItems),
        Container(
          height: 150,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _addItem(widget.list, widget.controller),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(widget.list[index]),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () =>
                          _removeItem(widget.list, widget.list[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
