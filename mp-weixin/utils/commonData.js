"use strict";
const timeTabData = [
  {
    value: 0,
    label: "上午08:00-12:00"
  },
  {
    value: 1,
    label: "下午12:30-18:00"
  }
];
const timeBaseData = [
  {
    value: 0,
    label: "08:00",
    disabled: false
  },
  {
    value: 1,
    label: "08:30",
    disabled: false
  },
  {
    value: 2,
    label: "09:00",
    disabled: false
  },
  {
    value: 3,
    label: "09:30",
    disabled: false
  },
  {
    value: 4,
    label: "10:00",
    disabled: false
  },
  {
    value: 5,
    label: "10:30",
    disabled: false
  },
  {
    value: 6,
    label: "11:00",
    disabled: false
  },
  {
    value: 7,
    label: "11:30",
    disabled: false
  },
  {
    value: 8,
    label: "12:00",
    disabled: false
  },
  {
    value: 9,
    label: "12:30",
    disabled: false
  },
  {
    value: 10,
    label: "13:00",
    disabled: false
  },
  {
    value: 11,
    label: "13:30",
    disabled: false
  },
  {
    value: 12,
    label: "14:00",
    disabled: false
  },
  {
    value: 13,
    label: "14:30",
    disabled: false
  },
  {
    value: 14,
    label: "15:00",
    disabled: false
  },
  {
    value: 15,
    label: "15:30",
    disabled: false
  },
  {
    value: 16,
    label: "16:00",
    disabled: false
  },
  {
    value: 17,
    label: "16:30",
    disabled: false
  },
  {
    value: 18,
    label: "17:00",
    disabled: false
  },
  {
    value: 19,
    label: "17:30",
    disabled: false
  },
  {
    value: 20,
    label: "18:00",
    disabled: false
  }
];
const listTabData = [
  {
    value: 0,
    label: "全部"
  },
  {
    value: 1,
    label: "待上门"
  }
];
const orderTabData = [
  {
    value: "",
    label: "全部"
  },
  {
    value: 0,
    label: "待支付"
  },
  {
    value: 1,
    label: "待执行"
  },
  {
    value: 2,
    label: "已执行"
  },
  {
    value: 3,
    label: "已完成"
  }
];
const cancelCauseData = [
  {
    value: 0,
    label: "不需要此项服务了"
  },
  {
    value: 1,
    label: "费用有点贵"
  },
  {
    value: 2,
    label: "临时有事，不方便服务"
  },
  {
    value: 3,
    label: "信息填写错误"
  },
  {
    value: 4,
    label: "重复下单"
  }
];
const payMethodList = ["微信支付"];
const billTabData = [
  {
    value: 0,
    label: "待支付"
  },
  {
    value: 1,
    label: "已支付"
  },
  {
    value: "",
    label: "全部"
  }
];
exports.billTabData = billTabData;
exports.cancelCauseData = cancelCauseData;
exports.listTabData = listTabData;
exports.orderTabData = orderTabData;
exports.payMethodList = payMethodList;
exports.timeBaseData = timeBaseData;
exports.timeTabData = timeTabData;
