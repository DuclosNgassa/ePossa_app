import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/bloc/transfer_manager.dart';
import 'package:epossa_app/converter/date_converter.dart';
import 'package:epossa_app/custom_widget/transfer_card.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/transfer.dart';
import 'package:epossa_app/model/transfer_wrapper.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  TransferManager _transferManager = new TransferManager();
  GlobalKey<RefreshIndicatorState> refreshKeyReceived;
  GlobalKey<RefreshIndicatorState> refreshKeySent;

  TabController _tabController;
  List<bool> transferListExpanded = new List();
  List<bool> receivedListExpanded = new List();

  @override
  void initState() {
    super.initState();
    refreshKeyReceived = GlobalKey<RefreshIndicatorState>();
    refreshKeySent = GlobalKey<RefreshIndicatorState>();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalStyling().init(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5,
            top: SizeConfig.blockSizeVertical * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            SizedBox(height: SizeConfig.blockSizeVertical * 2,),
            _buildTabs(),
            _buildTabBarView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return FadeAnimation(
      1.3,
      Text(
        AppLocalizations.of(context).translate('history'),
        style: GlobalStyling.styleHeaderWhite,
      ),
    );
  }

  Widget _buildTabs() {
    return FadeAnimation(
      1.6,
      Container(
          child: TabBar(
            labelStyle: GlobalStyling.styleTitleWhite,
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
      StreamBuilder<TransferWrapper>(
        stream: _transferManager.transferWrapper,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: SizeConfig.screenHeight * 0.69,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _buildReceivedFuture(snapshot.data.transferReceivedList),
                  _buildSentFuture(snapshot.data.transferSentList),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            MyNotification.showInfoFlushbar(
                context,
                AppLocalizations.of(context).translate('error'),
                AppLocalizations.of(context).translate('error_loading'),
                Icon(
                  Icons.info_outline,
                  size: 28,
                  color: Colors.redAccent,
                ),
                Colors.redAccent,
                3);
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
      ),
    );
  }

  Widget _buildSentFuture(List<Transfer> transfers) {
    _setSendListExpanded(transfers);
    if (transfers.length > 0) {
      return _buildSent(transfers);
    } else {
      return new Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 4,
            vertical: SizeConfig.blockSizeVertical * 4,
          ),
          child: Text(
            AppLocalizations.of(context).translate('no_transaction'),
            style: GlobalStyling.styleTitleWhite,
          ),
        ),
      );
    }
  }

  Widget _buildReceivedFuture(List<Transfer> transfers) {
    _setReceivedListExpanded(transfers);
    if (transfers.length > 0) {
      return _buildReceived(transfers);
    } else {
      return new Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 4,
            vertical: SizeConfig.blockSizeVertical * 4,
          ),
          child: Text(
            AppLocalizations.of(context).translate('no_received_transaction'),
            style: GlobalStyling.styleTitleWhite,
          ),
        ),
      );
    }
  }

  Widget _buildReceived(List<Transfer> receives) {
    return RefreshIndicator(
      key: refreshKeyReceived,
      onRefresh: () async {
        await _reloadData();
      },
      child: ListView.builder(
          itemCount: receives.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GlobalColor.colorWhite),
                child: ExpansionTile(
                  key: PageStorageKey<String>(
                      receives.elementAt(index).receiver),
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
          }),
    );
  }

  Widget _buildSent(List<Transfer> transfers) {
    return RefreshIndicator(
      key: refreshKeySent,
      onRefresh: () async {
        await _reloadData();
      },
      child: ListView.builder(
          itemCount: transfers.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GlobalColor.colorWhite),
                child: ExpansionTile(
                  leading: new Text(
                    DateConverter.convertToString(
                        transfers.elementAt(index).created_at, context),
                  ),
                  title: new Text(
                    transfers.elementAt(index).amount.toString() + " FCFA",
                    style: TextStyle(
                        fontSize:
                            (transferListExpanded.elementAt(index) == false)
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
          }),
    );
  }

  void _setReceivedListExpanded(List<Transfer> transferReceived) {
    for (int i = 0; i < transferReceived.length; i++) {
      receivedListExpanded.add(false);
    }
  }

  void _setSendListExpanded(List<Transfer> transferSent) {
    for (int i = 0; i < transferSent.length; i++) {
      transferListExpanded.add(false);
    }
  }

  Future<void> _reloadData() async {
    //TODO implements me!!!

    setState(() {});
  }
}
