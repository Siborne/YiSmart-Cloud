"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_index = require("../../utils/index.js");
const utils_validate = require("../../utils/validate.js");
const pages_api_family = require("../api/family.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  _component_NavBar();
}
if (!Math) {
  BoundForm();
}
const BoundForm = () => "./components/BoundForm.js";
const _sfc_main = {
  __name: "binding",
  setup(__props) {
    const store = common_vendor.useStore();
    const form = common_vendor.ref({});
    const isClick = common_vendor.ref(false);
    const pages = getCurrentPages();
    const page = common_vendor.ref();
    const capsuleBottom = common_vendor.ref();
    common_vendor.onLoad(() => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 12;
        }
      });
      page.value = pages[pages.length - 1].options;
    });
    const handleSub = async () => {
      if (!isClick.value) {
        isClick.value = true;
        const baseData = form.value.formData;
        if (baseData.name === "" || !baseData.name) {
          utils_index.tostTip("绑定内容不能为空");
          isClick.value = false;
          return false;
        }
        if (baseData.idCard === "" || !baseData.idCard) {
          utils_index.tostTip("绑定内容不能为空");
          isClick.value = false;
          return false;
        }
        if (baseData.remark === "" || !baseData.remark) {
          utils_index.tostTip("绑定内容不能为空");
          isClick.value = false;
          return false;
        }
        isClick.value = false;
        if (!utils_validate.validateIdentityCard(baseData.idCard)) {
          utils_index.tostTip("身份证号格式错误");
          return false;
        }
        await pages_api_family.elderBinging(baseData).then((res) => {
          if (res.code === 200) {
            utils_index.tostTip("绑定成功");
            form.value.clearFrom();
            setTimeout(() => {
              store.commit("setFootStatus", 1);
              common_vendor.index.navigateTo({
                url: "/pages/family/index"
              });
              clearTimeout();
            }, 500);
          } else {
            utils_index.tostTip(res.msg);
          }
        });
      }
    };
    const handleToLink = () => {
      if (page.value.str !== "home") {
        store.commit("setFootStatus", 1);
      }
      common_vendor.index.navigateBack({
        delta: 1
      });
    };
    return (_ctx, _cache) => {
      return {
        a: common_vendor.p({
          title: "绑定家人",
          isShowBack: true,
          handleToLink
        }),
        b: common_vendor.sr(form, "71f9d140-1", {
          "k": "form"
        }),
        c: common_vendor.o(_ctx.handleTime),
        d: common_vendor.o(_ctx.handleFamily),
        e: common_vendor.p({
          nowDate: _ctx.nowDate
        }),
        f: common_vendor.o(handleSub),
        g: capsuleBottom.value + "px"
      };
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-71f9d140"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/family/binding.vue"]]);
wx.createPage(MiniProgramPage);
