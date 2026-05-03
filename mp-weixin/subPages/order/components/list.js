"use strict";
const common_vendor = require("../../../common/vendor.js");
const utils_index = require("../../../utils/index.js");
const utils_commonData = require("../../../utils/commonData.js");
if (!Array) {
  const _easycom_uni_load_more2 = common_vendor.resolveComponent("uni-load-more");
  _easycom_uni_load_more2();
}
const _easycom_uni_load_more = () => "../../../uni_modules/uni-load-more/components/uni-load-more/uni-load-more.js";
if (!Math) {
  (_easycom_uni_load_more + EmptyPage)();
}
const EmptyPage = () => "../../../components/EmptyPage/index.js";
const _sfc_main = {
  __name: "list",
  props: {
    itemData: {
      type: Array,
      default: () => []
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
  emits: ["setTabIndex", "onReachBottom", "handleDelete"],
  setup(__props, { emit }) {
    const store = common_vendor.useStore();
    const users = store.state.user;
    const activeIndex = common_vendor.ref(users.orderStatus === "" ? 0 : users.orderStatus + 1);
    const scrollinto = common_vendor.ref("tab0");
    const emptyInfo = common_vendor.ref("未找到相关任务");
    const contentText = common_vendor.ref({
      // 加载状态说明
      contentdown: "上拉加载更多",
      contentrefresh: "努力加载中...",
      contentnomore: "- 没有更多了 -"
    });
    const pagesCount = common_vendor.ref(null);
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
    const handleCancel = (item) => {
      handleNavigate(item, 4);
    };
    const handleRefund = (item) => {
      handleNavigate(item, 5);
    };
    const handleNavigate = (item, num) => {
      common_vendor.index.navigateTo({
        url: `/subPages/order/cancel?id=${item.id}&type=${num}&tradingOrderNo=${item.tradingOrderNo}`
      });
    };
    const handleDelete = (id) => {
      emit("handleDelete", id);
    };
    const handlePay = (val) => {
      common_vendor.index.navigateTo({
        url: `/subPages/pay/index?item=${encodeURIComponent(JSON.stringify(val))}`
      });
    };
    const handleDetail = (id) => {
      common_vendor.index.navigateTo({
        url: `/subPages/order/details?id=${id}`
      });
    };
    common_vendor.onReachBottom(() => {
      emit("onReachBottom");
    });
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.f(common_vendor.unref(utils_commonData.orderTabData), (item, index, i0) => {
          return {
            a: common_vendor.t(item.label),
            b: index,
            c: common_vendor.n(activeIndex.value === index ? "active" : ""),
            d: common_vendor.o(($event) => changeTab(index), index)
          };
        }),
        b: common_vendor.n(activeIndex.value === 1 ? "active" : ""),
        c: scrollinto.value,
        d: common_vendor.f(__props.itemData, (item, index, i0) => {
          return common_vendor.e({
            a: item.nursingProjectVo.image,
            b: common_vendor.t(item.nursingProjectVo.name),
            c: item.status === 0
          }, item.status === 0 ? {} : {}, {
            d: item.status === 1
          }, item.status === 1 ? {} : {}, {
            e: item.status === 2
          }, item.status === 2 ? {} : {}, {
            f: item.status === 3
          }, item.status === 3 ? {} : {}, {
            g: item.status === 4
          }, item.status === 4 ? {} : {}, {
            h: item.status === 5
          }, item.status === 5 ? {} : {}, {
            i: common_vendor.t(item.elderVo.name),
            j: common_vendor.t(common_vendor.unref(utils_index.getNow)(item.estimatedArrivalTime)),
            k: common_vendor.t(common_vendor.unref(utils_index.getTime)(item.estimatedArrivalTime)),
            l: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(item.amount)),
            m: common_vendor.o(($event) => handleDetail(item.id), index),
            n: item.status === 0
          }, item.status === 0 ? {
            o: common_vendor.o(($event) => handleCancel(item), index),
            p: common_vendor.o(($event) => handlePay(item), index)
          } : {}, {
            q: item.status === 1 && !item.refundRecordVo.refundStatus || item.status === 1 && item.refundRecordVo.refundStatus === 3
          }, item.status === 1 && !item.refundRecordVo.refundStatus || item.status === 1 && item.refundRecordVo.refundStatus === 3 ? {
            r: common_vendor.o(($event) => handleRefund(item), index)
          } : {}, {
            s: item.status !== 0 && item.status !== 1
          }, item.status !== 0 && item.status !== 1 ? {
            t: common_vendor.o(($event) => handleDelete(item.id), index)
          } : {}, {
            v: index
          });
        }),
        e: __props.itemData.length > 6
      }, __props.itemData.length > 6 ? {
        f: common_vendor.p({
          status: __props.moreStatus,
          ["content-text"]: contentText.value
        })
      } : {}, {
        g: __props.itemData.length === 0 && __props.loading
      }, __props.itemData.length === 0 && __props.loading ? {
        h: common_vendor.p({
          emptyInfo: emptyInfo.value
        })
      } : {}, {
        i: capsuleBottom.value + "px"
      });
    };
  }
};
const Component = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/order/components/list.vue"]]);
wx.createComponent(Component);
