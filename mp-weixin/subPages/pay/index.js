"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_index = require("../../utils/index.js");
const utils_commonData = require("../../utils/commonData.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  const _component_net_fail = common_vendor.resolveComponent("net-fail");
  (_component_NavBar + _component_net_fail)();
}
const _sfc_main = {
  __name: "index",
  setup(__props) {
    const store = common_vendor.useStore();
    store.state.user;
    const formData = common_vendor.ref({});
    const rocallTime = common_vendor.ref("");
    const times = common_vendor.ref(null);
    const netStatus = common_vendor.ref(true);
    const activeRadio = common_vendor.ref(0);
    const isClick = common_vendor.ref(false);
    const capsuleBottom = common_vendor.ref();
    const isback = common_vendor.ref(false);
    common_vendor.onLoad((option) => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 10;
        }
      });
      formData.value = JSON.parse(decodeURIComponent(option.item));
    });
    common_vendor.onUnload(() => {
      store.commit("user/setOrderStatus", "");
    });
    common_vendor.onShow(() => {
      runTimeBack();
    });
    const handleSub = async () => {
      if (!isClick.value) {
        isClick.value = true;
        isback.value = true;
        const params = JSON.parse(formData.value.tradingVo.placeOrderJson);
        common_vendor.index.requestPayment({
          timeStamp: String(params.timeStamp),
          nonceStr: params.nonceStr,
          package: params.package,
          paySign: params.paySign,
          signType: "RSA",
          success() {
            common_vendor.index.reLaunch({
              url: `/subPages/success/index?item=${encodeURIComponent(
                JSON.stringify(formData.value)
              )}`
            });
          },
          complete(val) {
            if (val.errMsg === "requestPayment:fail cancel") {
              isClick.value = false;
            }
          }
        });
      }
    };
    const runTimeBack = () => {
      const end = Date.parse(formData.value.createTime.replace(/-/g, "/"));
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
        rocallTime.value = `${min}:${sec}`;
        if (min === "00" && sec === "00") {
          common_vendor.index.navigateTo({
            url: `/subPages/order/details?id=${formData.value.id}`
          });
          clearTimeout(times.value);
          return;
        }
        times.value = setTimeout(function() {
          runTimeBack();
        }, 1e3);
      }
    };
    const handleToRefresh = () => {
      getData();
    };
    const handleToLink = () => {
      isback.value = true;
      store.commit("user/setBackLike", "back");
      common_vendor.index.reLaunch({
        url: `/subPages/order/details?id=${formData.value.id}`
      });
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          title: "支付订单",
          isShowBack: true,
          handleToLink
        }),
        b: netStatus.value
      }, netStatus.value ? {
        c: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(formData.value.amount)),
        d: common_vendor.t(rocallTime.value),
        e: common_vendor.f(common_vendor.unref(utils_commonData.payMethodList), (item, index, i0) => {
          return {
            a: common_vendor.t(item),
            b: item,
            c: index == activeRadio.value,
            d: item
          };
        }),
        f: common_vendor.o((...args) => _ctx.styleChange && _ctx.styleChange(...args)),
        g: common_vendor.o(handleSub),
        h: capsuleBottom.value + "px"
      } : {
        i: common_vendor.p({
          handleToRefresh
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-9b64448a"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/pay/index.vue"]]);
wx.createPage(MiniProgramPage);
