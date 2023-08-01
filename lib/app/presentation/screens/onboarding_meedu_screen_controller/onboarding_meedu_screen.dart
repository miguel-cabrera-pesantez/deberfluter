import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_widgets/app/domain/models/slider_item_model.dart';
import 'package:biblioteca_widgets/app/presentation/screens/onboarding_meedu_screen_controller/onboarding_meedu_controller.dart';
import 'package:biblioteca_widgets/app/presentation/shared_widgets/slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter/scheduler.dart';

//TODO: Crear un controllador para manejar el estado
//TODO: Crear un provider para utilizar el controller
//TODO: Cambiar a StatelessWidget OnboardingMeeduScreen
//TODO: Utilizar el controlador para redibujar los cambios en la ui (Consumer) escuchando todo el controlador o parte de el
//TODO: van a subir este proyecto a los repositorios propios github (individuales), repositorio publico
//      enviarme la url de repositorio al grupo de whatsapp hasta el día Lunes 9pm.

final onboardingMeeduScreenController = SimpleProvider((ref) => OnboardingMeeduScreenController());

class OnboardingMeeduScreen extends StatelessWidget {
  const OnboardingMeeduScreen({super.key});


/*
class _OnboardingMeeduScreenState extends State<OnboardingMeeduScreen> {
  PageController pageViewController = PageController();
  bool endReached = false;*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer(
            builder: (_, ref, __) {
              final controller = ref.watch(onboardingMeeduScreenController);
              final pageController = controller.pageViewController;

              SchedulerBinding.instance.addPostFrameCallback((_) {
                pageController.addListener(() {
                  controller.onChangedView();
                });
              });
              return 
              PageView(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            children: sliders
                .map((slide) => SliderWidget(
                      slide: slide,
                    ))
                .toList(),
          );

        }),
        Positioned(
            right: 20,
            top: 60,
            child: TextButton(
              child: const Text("Skip"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        Positioned(
            bottom: 30,
            right: 30,
            child: Consumer(
              builder: (_, ref, __) {
                final controller = ref
                    .watch(onboardingMeeduScreenController
                        .select((controller) => controller.endReached))
                    .endReached;

                return controller
                    ? FadeInRight(
                        from: 15,
                        delay: const Duration(milliseconds: 500),
                        child: FilledButton(
                          child: const Text("Empezar"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    : Container();
              },
            ),
          ),
          
          
        ],
      ),
    );
}
}