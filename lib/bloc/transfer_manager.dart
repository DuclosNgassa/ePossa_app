import 'package:epossa_app/model/transfer.dart';
import 'package:epossa_app/model/transfer_wrapper.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/transfer_service.dart';
import 'package:epossa_app/util/constant_field.dart';

class TransferManager {
  TransferService _transferService = new TransferService();
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  Stream<TransferWrapper> get transferWrapper async* {
    String userPhone = await _sharedPreferenceService.read(USER_PHONE);
    List<Transfer> transferSentList =
        await _transferService.readBySender(userPhone);
    List<Transfer> transferReceivedList =
        await _transferService.readByReceiver(userPhone);

    TransferWrapper transferWrapper = new TransferWrapper();
    transferWrapper.transferSentList =
        await _transferService.sortDescending(transferSentList);
    transferWrapper.transferReceivedList =
        await _transferService.sortDescending(transferReceivedList);

    yield transferWrapper;
  }
}
