import 'dart:io';

import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/toast_services.dart';

class StepController {
  File? image;

  Future pickImage(List<XFile> images, ImageSource source) async {
    try {
      if (images.length >= 5) images = [];
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final bytes = await File(image.path).readAsBytes();
      final imagemfinal = decodeImage(bytes);
      final compressedImage = encodeJpg(imagemfinal!, quality: 50);

      final temporaryImage =
          await File(image.path).writeAsBytes(compressedImage);

      this.image = temporaryImage;
      images.add(image);
    } on Exception catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio das imagenes!');
    }
    return image;
  }

  void validate() {
    return showToast('¡Por favor seleccione su imagen!');
  }
}
