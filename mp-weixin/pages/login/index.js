"use strict";
const common_vendor = require("../../common/vendor.js");
const pages_api_login = require("../api/login.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _easycom_uni_popup2 = common_vendor.resolveComponent("uni-popup");
  _easycom_uni_popup2();
}
const _easycom_uni_popup = () => "../../uni_modules/uni-popup/components/uni-popup/uni-popup.js";
if (!Math) {
  (NavBar + _easycom_uni_popup)();
}
const NavBar = () => "../../components/Navbar/index.js";
const _sfc_main = {
  __name: "index",
  setup(__props) {
    const store = common_vendor.useStore();
    const popup = common_vendor.ref();
    const router = common_vendor.ref(store.state.router);
    const capsuleBottom = common_vendor.ref();
    common_vendor.onLoad(() => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 12;
        }
      });
    });
    const decryptPhoneNumber = (e) => {
      const detail = e && e.detail ? e.detail : {};
      const phoneCode = detail.code;
      const errMsg = detail.errMsg || "";
      if (errMsg.indexOf("ok") === -1) {
        if (errMsg.indexOf("deny") !== -1 || errMsg.indexOf("cancel") !== -1) {
          common_vendor.index.showToast({ title: "需要同意授权手机号", icon: "none" });
        } else {
          common_vendor.index.showToast({ title: "手机号授权失败，请重试", icon: "none" });
        }
        return;
      }
      if (!phoneCode) {
        common_vendor.index.showToast({ title: "未获取到手机号凭证，请在真机重试", icon: "none" });
        return;
      }
      common_vendor.wx$1.login({
        success(res) {
          if (!res || !res.code) {
            common_vendor.index.showToast({ title: "微信登录失败", icon: "none" });
            return;
          }
          pages_api_login.login({
            code: res.code,
            phoneCode,
            nickName: ""
          }).then((res2) => {
            if (res2 && res2.code === 200 && res2.data && res2.data.token) {
              common_vendor.index.setStorageSync("token", res2.data.token);
              common_vendor.index.setStorageSync("nickName", res2.data.nickName || "");
              common_vendor.index.showToast({
                title: "登录成功",
                duration: 1e3,
                icon: "none"
              });
              if (router.value) {
                common_vendor.index.redirectTo({
                  url: `/${router.value}`
                });
              }
            } else {
              common_vendor.index.showToast({
                title: (res2 && res2.msg) || "登录失败",
                icon: "none"
              });
            }
          }).catch(() => {
            common_vendor.index.showToast({ title: "网络异常，请重试", icon: "none" });
          });
        },
        fail() {
          common_vendor.index.showToast({ title: "微信登录失败", icon: "none" });
        }
      });
    };
    const handleClose = () => {
      popup.value.close();
    };
    const handleToLink = () => {
      common_vendor.index.navigateBack({
        delta: 1
      });
    };
    return (_ctx, _cache) => {
      return {
        a: common_vendor.p({
          title: "登录",
          isShowBack: true,
          handleToLink
        }),
        b: common_vendor.o(decryptPhoneNumber),
        c: common_vendor.o(handleClose),
        d: common_vendor.o(decryptPhoneNumber),
        e: common_vendor.sr(popup, "d08ef7d4-1", {
          "k": "popup"
        }),
        f: common_vendor.p({
          type: "bottom",
          ["safe-area"]: false
        }),
        g: capsuleBottom.value + "px"
      };
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-d08ef7d4"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/login/index.vue"]]);
wx.createPage(MiniProgramPage);
