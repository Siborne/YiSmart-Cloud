"use strict";
const common_vendor = require("./common/vendor.js");
const store_index = require("./store/index.js");
require("./store/modules/global.js");
require("./store/modules/user.js");
if (!Math) {
  "./pages/index/index.js";
  "./pages/family/index.js";
  "./pages/family/binding.js";
  "./pages/service/index.js";
  "./pages/service/details.js";
  "./pages/service/orderVerify.js";
  "./pages/login/index.js";
  "./pages/my/index.js";
  "./components/Foot/index.js";
  "./components/uni-phone/index.js";
  "./subPages/healthy/index.js";
  "./subPages/wuDataDetail/index.js";
  "./subPages/appointment/index.js";
  "./subPages/appointment/components/PickerView.js";
  "./subPages/appointment/list/index.js";
  "./subPages/introduce/index.js";
  "./subPages/bill/index.js";
  "./subPages/contract/index.js";
  "./subPages/order/index.js";
  "./subPages/order/cancel.js";
  "./subPages/order/details.js";
  "./subPages/success/index.js";
  "./subPages/search/index.js";
  "./subPages/pay/index.js";
}
const _sfc_main = {
  __name: "App",
  setup(__props) {
    return () => {
    };
  }
};
const App = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/App.vue"]]);
const NavBar = () => "./components/Navbar/index.js";
const NetFail = () => "./components/NetFail/index.js";
const UniFooter = () => "./components/Foot/index2.js";
const app = common_vendor.createApp(App);
app.use(store_index.store);
app.mount("#app");
app.component("NavBar", NavBar);
app.component("UniFooter", UniFooter);
app.component("NetFail", NetFail);
