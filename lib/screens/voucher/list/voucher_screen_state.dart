import 'package:equatable/equatable.dart';
import 'package:gizmoglobe_client/enums/processing/dialog_name_enum.dart';
import 'package:gizmoglobe_client/enums/processing/notify_message_enum.dart';
import 'package:gizmoglobe_client/enums/processing/process_state_enum.dart';
import 'package:gizmoglobe_client/objects/voucher_related/voucher.dart';

class VoucherScreenState extends Equatable {
  final List<Voucher> voucherList;
  final List<Voucher> ongoingList;
  final List<Voucher> upcomingList;
  final List<Voucher> inactiveList;
  final Voucher? selectedVoucher;
  final ProcessState processState;
  final DialogName dialogName;
  final NotifyMessage notifyMessage;

  const VoucherScreenState({
    this.voucherList = const [],
    this.ongoingList = const [],
    this.upcomingList = const [],
    this.inactiveList = const [],
    this.selectedVoucher,
    this.processState = ProcessState.idle,
    this.dialogName = DialogName.empty,
    this.notifyMessage = NotifyMessage.empty,
  });

  VoucherScreenState copyWith({
    List<Voucher>? voucherList,
    List<Voucher>? ongoingList,
    List<Voucher>? upcomingList,
    List<Voucher>? inactiveList,
    Voucher? selectedVoucher,
    ProcessState? processState,
    DialogName? dialogName,
    NotifyMessage? notifyMessage,
  }) {
    return VoucherScreenState(
      voucherList: voucherList ?? this.voucherList,
      ongoingList: ongoingList ?? this.ongoingList,
      upcomingList: upcomingList ?? this.upcomingList,
      inactiveList: inactiveList ?? this.inactiveList,
      selectedVoucher: selectedVoucher ?? this.selectedVoucher,
      processState: processState ?? this.processState,
      dialogName: dialogName ?? this.dialogName,
      notifyMessage: notifyMessage ?? this.notifyMessage,
    );
  }

  @override
  List<Object?> get props => [
        voucherList,
        ongoingList,
        upcomingList,
        inactiveList,
        selectedVoucher,
        processState,
        dialogName,
        notifyMessage,
      ];
}
