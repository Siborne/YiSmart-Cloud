"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_index = require("../../utils/index.js");
const pages_api_order = require("../../pages/api/order.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  _component_NavBar();
}
if (!Math) {
  Phone();
}
const Phone = () => "../../components/uni-phone/index2.js";
const _sfc_main = {
  __name: "details",
  setup(__props) {
    const store = common_vendor.useStore();
    const users = store.state.user;
    const baseData = common_vendor.ref({
      nursingProjectVo: {},
      elderVo: {}
    });
    const orderId = common_vendor.ref(null);
    const times = common_vendor.ref(null);
    const rocallTime = common_vendor.ref("");
    const capsuleBottom = common_vendor.ref();
    const typeVal = common_vendor.ref(users.backLink);
    const isback = common_vendor.ref(false);
    const phone = common_vendor.ref(null);
    common_vendor.onLoad((option) => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 10;
        }
      });
      orderId.value = option.id;
      getDetail();
    });
    const getDetail = async () => {
      await pages_api_order.getOrderDetail(orderId.value).then((res) => {
        if (res.code === 200) {
          baseData.value = res.data;
          runTimeBack(baseData.value.createTime);
        }
      });
    };
    const handleCancel = () => {
      handleNavigate(orderId.value, 4);
    };
    const handlePay = () => {
      common_vendor.index.navigateTo({
        url: `/subPages/pay/index?item=${encodeURIComponent(
          JSON.stringify(baseData.value)
        )}`
      });
    };
    const handleRefund = () => {
      handleNavigate(orderId.value, 5);
    };
    const handleService = () => {
      phone.value.popup.open("center");
    };
    const handleNavigate = (id, num) => {
      common_vendor.index.navigateTo({
        url: `/subPages/order/cancel?id=${id}&type=${num}&tradingOrderNo=${baseData.value.tradingOrderNo}`
      });
    };
    const runTimeBack = () => {
      const end = Date.parse(baseData.value.createTime.replace(/-/g, "/"));
      const now = Date.parse(/* @__PURE__ */ new Date());
      const m15 = 15 * 60 * 1e3;
      const msec = m15 - (now - end);
      if (msec < 0) {
        clearTimeout(times.value);
      } else {
        let min = parseInt(msec / 1e3 / 60 % 60);
        let sec = parseInt(msec / 1e3 % 60);
        if (min < 10) {
          min = `0${min}`;
        } else {
          min = min;
        }
        if (sec < 10) {
          sec = `0${sec}`;
        } else {
          sec = sec;
        }
        rocallTime.value = `${min}分${sec}秒`;
        if (min === "00" && sec === "00") {
          getDetail();
          clearTimeout(times.value);
        }
        times.value = setTimeout(function() {
          runTimeBack();
        }, 1e3);
      }
    };
    const handleToLink = () => {
      isback.value = true;
      if (typeVal.value === "back" || typeVal.value === "detail" || typeVal.value === "goods" || typeVal.value === "home") {
        common_vendor.index.reLaunch({
          url: `/subPages/order/index`
        });
      } else {
        common_vendor.index.navigateBack({
          delta: 1
        });
      }
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          title: "订单详情",
          isShowBack: true,
          handleToLink
        }),
        b: baseData.value.status === 0
      }, baseData.value.status === 0 ? {
        c: common_vendor.t(rocallTime.value)
      } : {}, {
        d: baseData.value.status === 1 && !baseData.value.refundRecordVo.refundStatus
      }, baseData.value.status === 1 && !baseData.value.refundRecordVo.refundStatus ? {} : {}, {
        e: baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 1
      }, baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 1 ? {} : {}, {
        f: baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 3
      }, baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 3 ? {
        g: common_vendor.t(baseData.value.refundRecordVo.refundMsg)
      } : {}, {
        h: baseData.value.status === 2
      }, baseData.value.status === 2 ? {} : {}, {
        i: baseData.value.status === 3
      }, baseData.value.status === 3 ? {} : {}, {
        j: baseData.value.status === 4
      }, baseData.value.status === 4 ? {
        k: common_vendor.t(baseData.value.reason ? baseData.value.reason : "超时未支付")
      } : {}, {
        l: baseData.value.status === 5
      }, baseData.value.status === 5 ? {} : {}, {
        m: baseData.value.nursingProjectVo.image,
        n: common_vendor.t(baseData.value.nursingProjectVo.name),
        o: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(baseData.value.amount)),
        p: common_vendor.t(baseData.value.nursingProjectVo.unit),
        q: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(baseData.value.amount)),
        r: common_vendor.t(baseData.value.estimatedArrivalTime ? common_vendor.unref(utils_index.getAllTime)(baseData.value.estimatedArrivalTime) : "--"),
        s: common_vendor.t(baseData.value.elderVo.name),
        t: baseData.value.remark
      }, baseData.value.remark ? {
        v: common_vendor.t(baseData.value.remark)
      } : {}, {
        w: common_vendor.t(baseData.value.orderNo),
        x: common_vendor.t(baseData.value.createTime ? common_vendor.unref(utils_index.getAllTime)(baseData.value.createTime) : "--"),
        y: baseData.value.status === 3
      }, baseData.value.status === 3 ? {
        z: common_vendor.t(baseData.value.updateTime ? common_vendor.unref(utils_index.getAllTime)(baseData.value.updateTime) : "--")
      } : {}, {
        A: baseData.value.status === 4 && baseData.value.reason
      }, baseData.value.status === 4 && baseData.value.reason ? {
        B: common_vendor.t(baseData.value.updateTime ? common_vendor.unref(utils_index.getAllTime)(baseData.value.updateTime) : "--")
      } : {}, {
        C: baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus || baseData.value.status === 5
      }, baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus || baseData.value.status === 5 ? common_vendor.e({
        D: baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus || baseData.value.status === 5
      }, baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus || baseData.value.status === 5 ? {
        E: common_vendor.t(baseData.value.refundRecordVo.memo),
        F: common_vendor.t(baseData.value.refundRecordVo.createTime ? common_vendor.unref(utils_index.getAllTime)(baseData.value.refundRecordVo.createTime) : "--")
      } : {}, {
        G: baseData.value.status === 5
      }, baseData.value.status === 5 ? {
        H: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(baseData.value.refundRecordVo.refundAmount)),
        I: common_vendor.t(baseData.value.refundRecordVo.updateTime ? common_vendor.unref(utils_index.getAllTime)(baseData.value.refundRecordVo.updateTime) : "--")
      } : {}) : {}, {
        J: baseData.value.status === 2 || baseData.value.status === 3
      }, baseData.value.status === 2 || baseData.value.status === 3 ? {
        K: common_vendor.t(baseData.value.nursingTaskVo.creator),
        L: common_vendor.t(baseData.value.nursingTaskVo.updateTime ? common_vendor.unref(utils_index.getAllTime)(baseData.value.nursingTaskVo.updateTime) : "--"),
        M: common_vendor.t(baseData.value.nursingTaskVo.mark),
        N: baseData.value.nursingTaskVo.taskImage
      } : {}, {
        O: capsuleBottom.value + "px",
        P: baseData.value.status === 0 || baseData.value.status === 2 || baseData.value.status === 1 && !baseData.value.refundRecordVo.refundStatus || baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 3
      }, baseData.value.status === 0 || baseData.value.status === 2 || baseData.value.status === 1 && !baseData.value.refundRecordVo.refundStatus || baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 3 ? common_vendor.e({
        Q: baseData.value.status === 0
      }, baseData.value.status === 0 ? {
        R: common_vendor.o(handleCancel)
      } : {}, {
        S: baseData.value.status === 0
      }, baseData.value.status === 0 ? {
        T: common_vendor.o(handlePay)
      } : {}, {
        U: baseData.value.status === 1 && !baseData.value.refundRecordVo.refundStatus || baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 3
      }, baseData.value.status === 1 && !baseData.value.refundRecordVo.refundStatus || baseData.value.status === 1 && baseData.value.refundRecordVo.refundStatus === 3 ? {
        V: common_vendor.o(handleRefund)
      } : {}, {
        W: baseData.value.status === 2
      }, baseData.value.status === 2 ? {
        X: common_vendor.o(handleService)
      } : {}) : {}, {
        Y: common_vendor.sr(phone, "efbca6f1-1", {
          "k": "phone"
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-efbca6f1"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/order/details.vue"]]);
wx.createPage(MiniProgramPage);
