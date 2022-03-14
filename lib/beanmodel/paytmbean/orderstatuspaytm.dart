class PaytmOrderStatus {
  PaytmOrderHead head;
  PaytmOrderBody body;

  PaytmOrderStatus({this.head, this.body});

  PaytmOrderStatus.fromJson(Map<String, dynamic> json) {
    head = json['head'] != null ? new PaytmOrderHead.fromJson(json['head']) : null;
    body = json['body'] != null ? new PaytmOrderBody.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'PaytmOrderStatus{head: $head, body: $body}';
  }
}

class PaytmOrderHead {
  dynamic responseTimestamp;
  dynamic version;
  dynamic signature;

  PaytmOrderHead({this.responseTimestamp, this.version, this.signature});

  PaytmOrderHead.fromJson(Map<String, dynamic> json) {
    responseTimestamp = json['responseTimestamp'];
    version = json['version'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseTimestamp'] = this.responseTimestamp;
    data['version'] = this.version;
    data['signature'] = this.signature;
    return data;
  }

  @override
  String toString() {
    return 'PaytmOrderHead{responseTimestamp: $responseTimestamp, version: $version, signature: $signature}';
  }
}

class PaytmOrderBody {
  PaytmOrderResultInfo resultInfo;
  dynamic txnId;
  dynamic orderId;
  dynamic txnAmount;
  dynamic txnType;
  dynamic mid;
  dynamic refundAmt;
  dynamic txnDate;

  PaytmOrderBody(
      {this.resultInfo,
        this.txnId,
        this.orderId,
        this.txnAmount,
        this.txnType,
        this.mid,
        this.refundAmt,
        this.txnDate});

  PaytmOrderBody.fromJson(Map<String, dynamic> json) {
    resultInfo = json['resultInfo'] != null
        ? new PaytmOrderResultInfo.fromJson(json['resultInfo'])
        : null;
    txnId = json['txnId'];
    orderId = json['orderId'];
    txnAmount = json['txnAmount'];
    txnType = json['txnType'];
    mid = json['mid'];
    refundAmt = json['refundAmt'];
    txnDate = json['txnDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultInfo != null) {
      data['resultInfo'] = this.resultInfo.toJson();
    }
    data['txnId'] = this.txnId;
    data['orderId'] = this.orderId;
    data['txnAmount'] = this.txnAmount;
    data['txnType'] = this.txnType;
    data['mid'] = this.mid;
    data['refundAmt'] = this.refundAmt;
    data['txnDate'] = this.txnDate;
    return data;
  }

  @override
  String toString() {
    return 'PaytmOrderBody{resultInfo: $resultInfo, txnId: $txnId, orderId: $orderId, txnAmount: $txnAmount, txnType: $txnType, mid: $mid, refundAmt: $refundAmt, txnDate: $txnDate}';
  }
}

class PaytmOrderResultInfo {
  dynamic resultStatus;
  dynamic resultCode;
  dynamic resultMsg;

  PaytmOrderResultInfo({this.resultStatus, this.resultCode, this.resultMsg});

  PaytmOrderResultInfo.fromJson(Map<String, dynamic> json) {
    resultStatus = json['resultStatus'];
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultStatus'] = this.resultStatus;
    data['resultCode'] = this.resultCode;
    data['resultMsg'] = this.resultMsg;
    return data;
  }

  @override
  String toString() {
    return 'PaytmOrderResultInfo{resultStatus: $resultStatus, resultCode: $resultCode, resultMsg: $resultMsg}';
  }
}