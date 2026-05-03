"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_commonData = require("../../utils/commonData.js");
const utils_index = require("../../utils/index.js");
const pages_api_order = require("../../pages/api/order.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  _component_NavBar();
}
const _sfc_main = {
  __name: "cancel",
  setup(__props) {
    const isSendRequest = common_vendor.ref(false);
    const isCurrent = common_vendor.ref(false);
    const cancelData = common_vendor.ref("");
    const orderId = common_vendor.ref(null);
    const type = common_vendor.ref(null);
    const title = common_vendor.ref("");
    const tradingOrderNo = common_vendor.ref("");
    const capsuleBottom = common_vendor.ref();
    common_vendor.onLoad((option) => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 10;
        }
      });
      orderId.value = option.id;
      tradingOrderNo.value = option.tradingOrderNo;
      type.value = option.type;
      if (type.value === "4") {
        title.value = "取消原因";
      } else {
        title.value = "退款原因";
      }
    });
    const radioChange = (e) => {
      cancelData.value = e.detail.value;
      isCurrent.value = true;
    };
    const handleSub = async () => {
      if (isCurrent.value) {
        if (!isSendRequest.value) {
          isSendRequest.value = true;
          let parent = {};
          if (type.value === "4") {
            parent = {
              ...parent,
              orderId: orderId.value,
              reason: cancelData.value
            };
            await pages_api_order.cancelOrder(parent).then((res) => {
              if (res.code === 200) {
                utils_index.tostTip("取消成功");
                setTimeout(() => {
                  isSendRequest.value = false;
                  common_vendor.index.navigateTo({
                    url: `/subPages/order/index`
                  });
                }, 1e3);
              } else {
                utils_index.tostTip(res.msg);
              }
            });
          } else {
            parent = {
              ...parent,
              productOrderNo: orderId.value,
              tradingOrderNo: tradingOrderNo.value,
              tradingChannel: cancelData.value
            };
            await pages_api_order.orderRefund(parent).then((res) => {
              if (res.code === 200) {
                utils_index.tostTip("退款成功");
                setTimeout(() => {
                  isSendRequest.value = false;
                  common_vendor.index.navigateTo({
                    url: `/subPages/order/index`
                  });
                }, 1e3);
              } else {
                utils_index.tostTip(res.msg);
              }
            });
          }
        }
      }
    };
    const handleToLink = () => {
      common_vendor.index.navigateBack({
        delta: 1
      });
    };
    return (_ctx, _cache) => {
      return {
        a: common_vendor.p({
          title: title.value,
          isShowBack: true,
          handleToLink
        }),
        b: common_vendor.f(common_vendor.unref(utils_commonData.cancelCauseData), (item, index, i0) => {
          return {
            a: common_vendor.t(item.label),
            b: item.label,
            c: index
          };
        }),
        c: common_vendor.o(radioChange),
        d: common_vendor.n(isCurrent.value ? "" : "forbid"),
        e: common_vendor.o(handleSub),
        f: capsuleBottom.value + "px"
      };
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-97264757"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/order/cancel.vue"]]);
wx.createPage(MiniProgramPage);
