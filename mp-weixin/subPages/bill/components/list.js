"use strict";
const common_vendor = require("../../../common/vendor.js");
const utils_index = require("../../../utils/index.js");
const pages_api_bill = require("../../../pages/api/bill.js");
const utils_commonData = require("../../../utils/commonData.js");
require("../../../utils/request.js");
require("../../../utils/env.js");
if (!Array) {
  const _easycom_uni_icons2 = common_vendor.resolveComponent("uni-icons");
  const _easycom_uni_load_more2 = common_vendor.resolveComponent("uni-load-more");
  (_easycom_uni_icons2 + _easycom_uni_load_more2)();
}
const _easycom_uni_icons = () => "../../../uni_modules/uni-icons/components/uni-icons/uni-icons.js";
const _easycom_uni_load_more = () => "../../../uni_modules/uni-load-more/components/uni-load-more/uni-load-more.js";
if (!Math) {
  (_easycom_uni_icons + _easycom_uni_load_more + EmptyPage + DetailView)();
}
const DetailView = () => "./detail.js";
const EmptyPage = () => "../../../components/EmptyPage/index.js";
const _sfc_main = {
  __name: "list",
  props: {
    itemData: {
      type: Array,
      default: () => []
    },
    orderName: {
      type: String,
      default: ""
    },
    moreStatus: {
      type: String,
      default: "noMore"
    },
    loading: {
      type: Boolean,
      default: false
    }
  },
  emits: [
    "setTabIndex",
    "onReachBottom",
    "setElderId",
    "handleFamily"
  ],
  setup(__props, { expose, emit }) {
    const activeIndex = common_vendor.ref(0);
    const active = common_vendor.ref(0);
    const scrollinto = common_vendor.ref("tab0");
    const emptyInfo = common_vendor.ref("未找到相关数据");
    const isClick = common_vendor.ref(false);
    const detailPopup = common_vendor.ref(null);
    const contentText = common_vendor.ref({
      // 加载状态说明
      contentdown: "上拉加载更多",
      contentrefresh: "努力加载中...",
      contentnomore: "- 没有更多了 -"
    });
    const pagesCount = common_vendor.ref(null);
    const baseDate = common_vendor.ref({
      checkInConfigVo: {}
    });
    const capsuleBottom = common_vendor.ref();
    common_vendor.onLoad(() => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 12;
        }
      });
      const pages = getCurrentPages();
      pagesCount.value = pages.length;
    });
    const changeTab = (index) => {
      if (activeIndex.value === index) {
        return;
      }
      activeIndex.value = index;
      emit("setTabIndex", index);
    };
    const getDetail = async (id) => {
      await pages_api_bill.getBillDetail(id).then((res) => {
        baseDate.value = res.data;
      });
    };
    const handleSub = async (val) => {
      if (!isClick.value) {
        isClick.value = true;
        const params = {
          id: val.id,
          payableAmount: val.payableAmount
        };
        await pages_api_bill.billPay(params).then((res) => {
          if (res.code === 200) {
            const params2 = JSON.parse(res.data.placeOrderJson);
            common_vendor.index.requestPayment({
              timeStamp: String(params2.timeStamp),
              nonceStr: params2.nonceStr,
              package: params2.package,
              paySign: params2.paySign,
              signType: "RSA",
              success() {
                utils_index.tostTip("支付成功");
                isClick.value = false;
              },
              complete(val2) {
                isClick.value = false;
                if (val2.errMsg === "requestPayment:fail cancel") {
                  utils_index.tostTip("支付失败");
                }
              }
            });
          }
        }).catch((err) => {
          common_vendor.index.showToast({
            title: err.msg,
            duration: 1e3,
            icon: "none"
          });
        });
      }
    };
    const handleDetail = (id) => {
      detailPopup.value.popup.open("bottom");
      getDetail(id);
    };
    const handleFamily = (val) => {
      emit("handleFamily", val);
    };
    common_vendor.onReachBottom(() => {
      emit("onReachBottom");
    });
    expose({
      active
    });
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.f(common_vendor.unref(utils_commonData.billTabData), (item, index, i0) => {
          return {
            a: common_vendor.t(item.label),
            b: index,
            c: common_vendor.n(activeIndex.value === index ? "active" : ""),
            d: common_vendor.o(($event) => changeTab(index), index)
          };
        }),
        b: common_vendor.n(activeIndex.value === 1 ? "active" : ""),
        c: common_vendor.t(__props.orderName),
        d: common_vendor.p({
          type: "bottom",
          size: "14"
        }),
        e: common_vendor.o(($event) => handleFamily("bottom")),
        f: scrollinto.value,
        g: common_vendor.f(__props.itemData, (item, index, i0) => {
          return common_vendor.e({
            a: common_vendor.t(item.billNo),
            b: item.transactionStatus === 0
          }, item.transactionStatus === 0 ? {} : {}, {
            c: item.transactionStatus === 1
          }, item.transactionStatus === 1 ? {} : {}, {
            d: item.transactionStatus === 2
          }, item.transactionStatus === 2 ? {} : {}, {
            e: common_vendor.t(item.billType === 0 ? "月度账单" : "费用账单"),
            f: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(item.billAmount)),
            g: common_vendor.t(item.elderVo.name),
            h: common_vendor.t(common_vendor.unref(utils_index.getNowMonth)(item.billMonth)),
            i: common_vendor.t(common_vendor.unref(utils_index.getAllTime)(item.createTime)),
            j: common_vendor.t(common_vendor.unref(utils_index.getAllTime)(item.paymentDeadline)),
            k: item.transactionStatus === 0
          }, item.transactionStatus === 0 ? {
            l: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(item.payableAmount))
          } : {}, {
            m: common_vendor.o(($event) => handleDetail(item.id), index),
            n: item.transactionStatus === 0 && item.billType === 0
          }, item.transactionStatus === 0 && item.billType === 0 ? {
            o: common_vendor.o(($event) => handleSub(item), index)
          } : {}, {
            p: index
          });
        }),
        h: __props.itemData.length > 6
      }, __props.itemData.length > 6 ? {
        i: common_vendor.p({
          status: __props.moreStatus,
          ["content-text"]: contentText.value
        })
      } : {}, {
        j: __props.itemData.length === 0 && __props.loading
      }, __props.itemData.length === 0 && __props.loading ? {
        k: common_vendor.p({
          emptyInfo: emptyInfo.value
        })
      } : {}, {
        l: common_vendor.sr(detailPopup, "3d401eef-3", {
          "k": "detailPopup"
        }),
        m: common_vendor.p({
          baseDate: baseDate.value
        }),
        n: capsuleBottom.value + "px"
      });
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/bill/components/list.vue"]]);
wx.createComponent(Component);
