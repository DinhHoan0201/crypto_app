import 'package:flutter/material.dart';
import 'package:crypto_app/service/fetch_API.dart';
import 'package:crypto_app/model/OHLC_coin.dart';
import 'package:k_chart_plus/k_chart_plus.dart';
import 'dart:async';

class CandleChart extends StatefulWidget {
  final String coinId;
  final int days;
  const CandleChart({super.key, required this.coinId, this.days = 1});
  @override
  _CandleChartState createState() => _CandleChartState();
}

class _CandleChartState extends State<CandleChart>
    with AutomaticKeepAliveClientMixin {
  final timerange = ['1', '3', '7'];
  List<KLineEntity> candles = [];
  List<OHLCcoinModel> ohlcData = [];
  bool isLoading = true;
  int selectedDay = 1;

  late Timer _timer;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _fetchOHLCdata(widget.coinId, widget.days);
    _timer = Timer.periodic(
      const Duration(minutes: 3),
      (_) => _fetchOHLCdata(widget.coinId, widget.days),
    );
  }

  Future<void> _fetchOHLCdata(String coinId, int days) async {
    setState(() => isLoading = true);
    try {
      ohlcData = await fetchOHLCdata(coinId, days);
      candles =
          ohlcData.map((e) {
            return KLineEntity.fromCustom(
              open: e.open,
              high: e.high,
              low: e.low,
              close: e.close,
              vol: 0,
              time: e.timestamp.toInt(),
            );
          }).toList();

      DataUtil.calculate(candles, [5, 10, 20]);

      setState(() {
        candles = candles;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading OHLC: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      timerange.map((dayStr) {
                        final int day = int.parse(dayStr);
                        final isSelected = selectedDay == day;
                        return TextButton(
                          onPressed: () {
                            setState(() {
                              selectedDay = day;
                            });
                            _fetchOHLCdata(widget.coinId, day);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                isSelected ? Colors.yellow : Colors.white,
                          ),
                          child: Text(
                            '$day d',
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 12), // khoảng cách giữa Row và chart
                Expanded(
                  child: KChartWidget(
                    candles,
                    ChartStyle(),
                    ChartColors(),
                    isLine: false,
                    volHidden: false,
                    showNowPrice: true,
                    isOnDrag: (bool drag) {},
                    maDayList: [5, 10, 20],
                    isTrendLine: false,
                    mBaseHeight: 350,
                    timeFormat: TimeFormat.YEAR_MONTH_DAY,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
