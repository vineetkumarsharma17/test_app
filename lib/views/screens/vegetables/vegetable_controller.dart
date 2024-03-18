import 'package:get/get.dart';
import 'package:test_app/models/vegetable.dart';

class VegetableController extends GetxController {
  RxList<Vegetable> vegetableList = RxList<Vegetable>([
    Vegetable(
        name: "Boston Lettuce",
        price: '1.10',
        image: "assets/images/img1.png",
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac lorem quis neque porta suscipit. Nullam vitae magna euismod, bibendum eros et, tempus lorem. Integer eu sapien velit. Sed sed tincidunt dolor. Vestibulum non ipsum sit amet turpis aliquet aliquet. Nunc commodo, dolor sit amet consectetur fermentum, dolor nulla dictum nulla, quis gravida felis odio sed nisl. Sed nec orci vitae velit mollis faucibus. Sed et quam vel velit commodo luctus. Sed auctor massa eget velit fermentum, a congue lorem finibus.',
        weight: "150g"),
    Vegetable(
        name: "Boston Lettuce",
        price: '1.10',
        image: "assets/images/img2.png",
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac lorem quis neque porta suscipit. Nullam vitae magna euismod, bibendum eros et, tempus lorem. Integer eu sapien velit. Sed sed tincidunt dolor. Vestibulum non ipsum sit amet turpis aliquet aliquet. Nunc commodo, dolor sit amet consectetur fermentum, dolor nulla dictum nulla, quis gravida felis odio sed nisl. Sed nec orci vitae velit mollis faucibus. Sed et quam vel velit commodo luctus. Sed auctor massa eget velit fermentum, a congue lorem finibus.',
        weight: "150g"),
    Vegetable(
        name: "Boston Lettuce",
        price: '1.10',
        image: "assets/images/img3.png",
        details:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac lorem quis neque porta suscipit. Nullam vitae magna euismod, bibendum eros et, tempus lorem. Integer eu sapien velit. Sed sed tincidunt dolor. Vestibulum non ipsum sit amet turpis aliquet aliquet. Nunc commodo, dolor sit amet consectetur fermentum, dolor nulla dictum nulla, quis gravida felis odio sed nisl. Sed nec orci vitae velit mollis faucibus. Sed et quam vel velit commodo luctus. Sed auctor massa eget velit fermentum, a congue lorem finibus.',
        weight: "150g"),
  ]);
}
