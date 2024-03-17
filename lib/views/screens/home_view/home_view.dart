import 'package:test_app/views/screens/add_product/product_binding.dart';
import 'package:test_app/views/screens/home_view/widgets/product_card.dart';
import 'package:test_app/views/widgets/buttons.dart';
import 'package:test_app/views/widgets/shimmer.dart';

import '../../../helper/app_export.dart';
import '../add_product/add_product_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
                onPressed: () => controller.signOut(),
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        drawer: Drawer(),
        floatingActionButton: CircleAvatar(
          child: IconButton(
              onPressed: () {
                Get.to(() => const CreateEditProduct(),
                    binding: ProductBindings());
              },
              icon: Icon(Icons.add)),
        ),
        body: RefreshIndicator(
          onRefresh: () async => controller.getProducts(),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(() => controller.isLoading.value
                        ? AppShimmer(
                            itemCount: 5,
                          )
                        : controller.productsList.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 100),
                                child: Text("No Product Found."),
                              )
                            : ListView.builder(
                                itemCount: controller.productsList.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (bc, i) {
                                  return ProductWidget(
                                      product: controller.productsList[i]);
                                })),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
