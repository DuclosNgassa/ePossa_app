import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/converter/date_converter.dart';
import 'package:epossa_app/custom_widget/transfer_card.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/transfer.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/services/transfer_service.dart';
import 'package:epossa_app/util/size_config.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Transfer> transferList = new List();
  List<bool> transferListExpanded = new List();
  List<Transfer> receivedList = new List();
  List<bool> receivedListExpanded = new List();

  TransferService _transferService = new TransferService();

  bool isReceiveExpanded = false;
  bool isSendExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    isReceiveExpanded = false;
    isSendExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5,right: SizeConfig.blockSizeHorizontal * 5, top: SizeConfig.blockSizeVertical *5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          _buildTabs(),
          _buildTabBarView(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return FadeAnimation(
      1.3,
      Text(
        AppLocalizations.of(context).translate('history'),
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTabs() {
    return FadeAnimation(
      1.6,
      Container(
          child: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            text: AppLocalizations.of(context).translate('receiving'),
          ),
          Tab(
            text: AppLocalizations.of(context).translate('sending'),
          ),
        ],
      )),
    );
  }

  Widget _buildTabBarView() {
    return FadeAnimation(
      1.9,
      Container(
        height: SizeConfig.screenHeight * 0.69,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _buildReceivedFuture(),
            _buildSentFuture(),
          ],
        ),
      ),
    );
  }

  Widget _buildReceived(List<Transfer> receives) {
    return ListView.builder(
        itemCount: receives.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: ExpansionTile(
                key: PageStorageKey<String>(
                    receives.elementAt(index).phone_number_receiver),
                leading: new Text(DateConverter.convertToString(
                    receives.elementAt(index).created_at, context)),
                title: Container(
                  child: new Text(
                    receives.elementAt(index).amount.toString() + " FCFA",
                    style: TextStyle(
                        fontSize:
                            (receivedListExpanded.elementAt(index) == false)
                                ? 18
                                : 22),
                  ),
                ),
                children: <Widget>[
                  Container(
                    child: new TransferCard(
                      transfer: receives.elementAt(index),
                      isReceiver: true,
                    ),
                  ),
                ],
                trailing: (receivedListExpanded.elementAt(index) == false)
                    ? Icon(
                        Icons.arrow_drop_down,
                        size: 32,
                        color: Color.fromRGBO(112, 139, 245, 55),
                      )
                    : Icon(
                        Icons.arrow_drop_up,
                        size: 32,
                        color: Color.fromRGBO(112, 139, 245, 55),
                      ),
                onExpansionChanged: (value) {
                  setState(() {
                    receivedListExpanded[index] = value;
                  });
                },
              ),
            ),
          );
        });
  }

  Widget _buildSent(List<Transfer> transfers) {
    return ListView.builder(
        itemCount: transfers.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: ExpansionTile(
                leading: new Text(
                  DateConverter.convertToString(
                      transfers.elementAt(index).created_at, context),
                ),
                title: new Text(
                  transfers.elementAt(index).amount.toString() + " FCFA",
                  style: TextStyle(
                      fontSize: (transferListExpanded.elementAt(index) == false)
                          ? 18
                          : 22),
                ),
                children: <Widget>[
                  new TransferCard(
                    transfer: transfers.elementAt(index),
                    isReceiver: false,
                  ),
                ],
                trailing: (transferListExpanded.elementAt(index) == false)
                    ? Icon(
                        Icons.arrow_drop_down,
                        size: 32,
                        color: Color.fromRGBO(112, 139, 245, 55),
                      )
                    : Icon(
                        Icons.arrow_drop_up,
                        size: 32,
                        color: Color.fromRGBO(112, 139, 245, 55),
                      ),
                onExpansionChanged: (value) {
                  setState(() {
                    transferListExpanded[index] = value;
                  });
                },
              ),
            ),
          );
        });
  }

  Widget _buildSentFuture() {
    return FutureBuilder(
      future: _loadTransfers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return _buildSent(snapshot.data);
          } else {
            return new Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 4,
                  vertical: SizeConfig.blockSizeVertical * 4,
                ),
                child: Text(
                  AppLocalizations.of(context).translate('no_transaction'),
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('error'),
              AppLocalizations.of(context)
                  .translate('error_loading_transactions'),
              Icon(
                Icons.info_outline,
                size: 28,
                color: Colors.redAccent,
              ),
              Colors.redAccent,
              4);
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/gif/loading.gif",
              ),
              Text(
                AppLocalizations.of(context).translate('loading'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReceivedFuture() {
    return FutureBuilder(
      future: _loadReceived(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return _buildReceived(snapshot.data);
          } else {
            return new Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 4,
                  vertical: SizeConfig.blockSizeVertical * 4,
                ),
                child: Text(
                  AppLocalizations.of(context)
                      .translate('no_received_transaction'),
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('error'),
              AppLocalizations.of(context)
                  .translate('error_loading_transactions'),
              Icon(
                Icons.info_outline,
                size: 28,
                color: Colors.redAccent,
              ),
              Colors.redAccent,
              4);
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/gif/loading.gif",
              ),
              Text(
                AppLocalizations.of(context).translate('loading'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Transfer>> _loadTransfers() async {
    List<Transfer> transferItems = await _transferService.fetchTransfer();

    transferList = _transferService.sortDescending(transferItems);

    for (int i = 0; i < transferItems.length; i++) {
      transferListExpanded.add(false);
    }

    return transferList;
  }

  Future<List<Transfer>> _loadReceived() async {
    List<Transfer> receivedItems = await _transferService.fetchReceived();

    receivedList = _transferService.sortDescending(receivedItems);

    for (int i = 0; i < receivedItems.length; i++) {
      receivedListExpanded.add(false);
    }

    return receivedList;
  }
}
