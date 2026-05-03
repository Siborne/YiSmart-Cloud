"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_index = require("../../utils/index.js");
const pages_api_service = require("../api/service.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  const _component_net_fail = common_vendor.resolveComponent("net-fail");
  (_component_NavBar + _component_net_fail)();
}
const _sfc_main = {
  __name: "orderVerify",
  setup(__props) {
    const store = common_vendor.useStore();
    const baseData = common_vendor.ref([]);
    const formData = common_vendor.ref({});
    const remark = common_vendor.ref(null);
    const netStatus = common_vendor.ref(true);
    const isClick = common_vendor.ref(false);
    const dateTime = common_vendor.ref(null);
    const capsuleBottom = common_vendor.ref();
    common_vendor.onLoad((option) => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 10;
        }
      });
      formData.value = JSON.parse(decodeURIComponent(option.item));
      dateTime.value = `${utils_index.getNow(formData.value.estimatedArrivalTime)} ${utils_index.getTime(
        formData.value.estimatedArrivalTime
      )}`;
    });
    common_vendor.onShow(() => {
      getData();
    });
    const getData = async () => {
      await pages_api_service.goodsDetail(formData.value.projectId).then((res) => {
        if (res.code === 200) {
          const {
            data
          } = res;
          baseData.value = data;
          netStatus.value = true;
        }
      }).catch((err) => {
        common_vendor.index.showToast({
          title: err.msg,
          duration: 1e3,
          icon: "none"
        });
        netStatus.value = false;
      });
    };
    const handleSub = async () => {
      if (!isClick.value) {
        isClick.value = true;
        const params = {
          ...formData.value,
          remark: remark.value
        };
        await pages_api_service.goodsPay(params).then((res) => {
          if (res.code === 200) {
            isClick.value = false;
            utils_index.tostTip("下单成功");
            store.commit("user/setBackLike", "goods");
            common_vendor.index.redirectTo({
              url: `/subPages/pay/index?item=${encodeURIComponent(
                JSON.stringify(res.data)
              )}`
            });
          } else {
            utils_index.tostTip(res.msg);
          }
        });
      }
    };
    const handleToRefresh = () => {
      getData();
    };
    const handleBlur = (e) => {
      const text = utils_index.warnBlank(e.detail.value);
      remark.value = text.substring(0, 50);
    };
    const handleToLink = () => {
      common_vendor.index.navigateTo({
        url: `/pages/service/details?item=${encodeURIComponent(
          JSON.stringify(formData.value)
        )}`
      });
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          title: "确认订单",
          isShowBack: true,
          handleToLink
        }),
        b: netStatus.value
      }, netStatus.value ? {
        c: baseData.value.image,
        d: common_vendor.t(baseData.value.name),
        e: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(baseData.value.price)),
        f: common_vendor.t(baseData.value.unit),
        g: common_vendor.t(formData.value.name),
        h: common_vendor.t(dateTime.value),
        i: common_vendor.t(common_vendor.unref(utils_index.decimalsReplenish)(baseData.value.price)),
        j: common_vendor.o(handleBlur),
        k: remark.value,
        l: common_vendor.o(($event) => remark.value = $event.detail.value),
        m: common_vendor.t(remark.value ? remark.value.length : 0),
        n: common_vendor.o(handleSub),
        o: capsuleBottom.value + "px"
      } : {
        p: common_vendor.p({
          handleToRefresh
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-c401c9b4"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/service/orderVerify.vue"]]);
wx.createPage(MiniProgramPage);
