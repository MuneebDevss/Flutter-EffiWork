// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final DraggableScrollableController sheetController =
//       DraggableScrollableController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             color: Theme.of(context).canvasColor,
//           ),
//           DraggableScrollableSheet(
//             minChildSize: 0.3,
//             controller: sheetController,
//             builder: (BuildContext context, scrollController) {
//               return Container(
//                 clipBehavior: Clip.hardEdge,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).canvasColor,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   ),
//                 ),
//                 child: CustomScrollView(
//                   controller: scrollController,
//                   slivers: [
//                     SliverToBoxAdapter(
//                       child: Center(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).hintColor,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10)),
//                           ),
//                           height: 4,
//                           width: 40,
//                           margin: const EdgeInsets.symmetric(vertical: 10),
//                         ),
//                       ),
//                     ),
//                     const SliverAppBar(
//                       title: Text('My App'),
//                       primary: false,
//                       pinned: true,
//                       centerTitle: false,
//                     ),
//                     SliverList.list(children: [
//                       FilledButton.tonal(
//                         style: ButtonStyle(
//                           backgroundBuilder: (context, states, child) {
//                             return Container(
//                                 decoration: BoxDecoration(
//                               color: Theme.of(context).hintColor,
//                             ));
//                           },
//                         ),
//                         onPressed: () {
//                           sheetController.animateTo(
//                             0,
//                             duration: const Duration(milliseconds: 20),
//                             curve: Curves.bounceIn,
//                           );
//                         },
//                         child: const Text('Scrool to 0.8'),
//                       ),
//                       const ListTile(title: Text('Jane Doe')),
//                       const ListTile(title: Text('Jack Reacher')),
//                     ])
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/Category/Presentation/Pages/categories.dart';
import 'package:where_is_my_stuff/Features/HomePage/Presentation/Controller/main_page_controller.dart';
import 'package:where_is_my_stuff/Features/Inventory/Presentation/Pages/inventory.dart';
import 'package:where_is_my_stuff/Features/QuickAdd/Presentation/Pages/quick_add.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final MainPageController mainPageController = MainPageController();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: width / 1.07,
                height: 50,
                child: TextField(
                  focusNode: widget.mainPageController.searchNode,
                  onTapOutside: (value) {
                    widget.mainPageController.searchNode.unfocus();
                  },
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //DashBoardContainer For OverView
                    Container(
                      height: 110,
                      width: 338,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFAAB8FF),
                              Color(0xFF92E0F8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: DashBoardRowText(
                                text1: 'Total Items', text2: 'To-Do\'s'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DashBoardRowText(
                                text1: widget.mainPageController.totalItems
                                    .toString(),
                                text2:
                                    widget.mainPageController.toDos.toString()),
                          )
                        ],
                      ),
                    ),
                    const SpaceBetweenSections(),
                    NavigationButton(
                      image: 'assets/Icons/Inventory.png',
                      text: 'Inventory',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyInventory())),
                    ),
                    const SpaceBetweenItems(),
                    NavigationButton(
                      image: 'assets/Icons/Categories.png',
                      text: 'Categories',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categories())),
                    ),
                    const SpaceBetweenItems(),
                    NavigationButton(
                      image: 'assets/Icons/TODO.png',
                      text: 'To-Do',
                      onTap: () {},
                    ),
                    const SpaceBetweenItems(),
                    NavigationButton(
                      image: 'assets/Icons/QuickAdd.png',
                      text: 'Quick Add',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuickAdd())),
                    ),
                    const SpaceBetweenItems(),
                    NavigationButton(
                      image: 'assets/Icons/Settings.png',
                      text: 'Settings',
                      onTap: () {},
                    ),
                    const SpaceBetweenItems(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });
  final String image, text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,
        width: 338,
        decoration: BoxDecoration(
            color: const Color(0xFFFF8A8A),
            borderRadius: BorderRadius.circular(Sizes.borderRadiusLg)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Image.asset(image),
            const SizedBox(width: 10),
            Text(text,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class DashBoardRowText extends StatelessWidget {
  const DashBoardRowText({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1, text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          text1,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )),
        Expanded(
            child: Text(
          text2,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )),
      ],
    );
  }
}
