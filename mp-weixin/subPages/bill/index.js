"use strict";
const common_vendor = require("../../common/vendor.js");
const pages_api_family = require("../../pages/api/family.js");
const pages_api_bill = require("../../pages/api/bill.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  const _component_net_fail = common_vendor.resolveComponent("net-fail");
  (_component_NavBar + _component_net_fail)();
}
if (!Math) {
  (List + FamilyView)();
}
const List = () => "./components/list.js";
const FamilyView = () => "../../components/FamilyView/index.js";
const _sfc_main = {
  __name: "index",
  setup(__props) {
    const store = common_vendor.useStore();
    const users = store.state.user;
    const typeVal = common_vendor.ref(users.backLink);
    const list = common_vendor.ref(null);
    const itemData = common_vendor.ref([]);
    const itemNameData = common_vendor.ref([]);
    const moreStatus = common_vendor.ref("more");
    const netStatus = common_vendor.ref(true);
    const loading = common_vendor.ref(false);
    const orderName = common_vendor.ref("全部");
    const formData = common_vendor.ref({});
    const billVal = common_vendor.ref("bill");
    let params = common_vendor.reactive({
      pageNum: 1,
      pageSize: 10,
      transactionStatus: 0,
      elderId: ""
    });
    const pageNum = common_vendor.ref(1);
    const pages = common_vendor.ref(0);
    const isSendRequest = common_vendor.ref(false);
    const isback = common_vendor.ref(false);
    const familyPopup = common_vendor.ref(null);
    common_vendor.onLoad((option) => {
      if (option.id !== void 0) {
        params.elderId = option.id;
        formData.value.elderId = option.id;
        orderName.value = option.name;
      }
    });
    common_vendor.onShow(() => {
      getNewData();
    });
    const getElderList = async () => {
      await pages_api_family.getAllElderList().then((res) => {
        if (res.code === 200) {
          itemNameData.value = res.data;
          const obj = {
            elderId: -1,
            elderVo: {
              elderId: -1,
              name: "全部"
            }
          };
          itemNameData.value.unshift(obj);
        }
      });
    };
    const getNewData = async () => {
      params = {
        pageSize: params.pageSize,
        pageNum: pageNum.value,
        transactionStatus: params.transactionStatus,
        elderId: params.elderId
      };
      if (isSendRequest.value) {
        return;
      }
      moreStatus.value = "loading";
      loading.value = false;
      await pages_api_bill.getBillList(params).then((res) => {
        if (res.code === 200) {
          const {
            data
          } = res;
          const items = data.records == null ? [] : data.records;
          moreStatus.value = items.length < 10 ? "no-more" : "more";
          params.pageNum == 1 ? itemData.value = void 0 : null;
          itemData.value = itemData.value ? [...itemData.value, ...items] : items;
          pages.value = data.pages;
          if (data.pages === pageNum.value) {
            isSendRequest.value = true;
            moreStatus.value = "noMore";
          }
          common_vendor.index.stopPullDownRefresh();
          netStatus.value = true;
          loading.value = true;
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
    const setTabIndex = (index) => {
      if (index >= 2) {
        store.commit("user/setOrderStatus", index - 1);
        params.transactionStatus = index - 1;
      } else {
        store.commit("user/setOrderStatus", "");
        params.transactionStatus = index;
      }
      pageNum.value = 1;
      if (index === 2) {
        params.transactionStatus = "";
      }
      isSendRequest.value = false;
      orderName.value = "全部";
      params.elderId = "";
      list.value.active = 0;
      getNewData();
    };
    const setElderId = (val) => {
      orderName.value = val.elderVo.name;
      if (val.elderVo.elderId === -1) {
        params.elderId = "";
        formData.value.elderId = -1;
      } else {
        formData.value.elderId = val.elderId;
        params.elderId = val.elderId;
      }
      getNewData();
    };
    const onReachBottom = () => {
      if (pageNum.value >= pages.value) {
        moreStatus.value = "noMore";
        return false;
      }
      moreStatus.value = "loading";
      const times = setTimeout(() => {
        pageNum.value++;
        getNewData();
        clearTimeout(times);
      }, 1e3);
    };
    const handleToLink = () => {
      store.commit("user/setOrderStatus", "");
      isback.value = true;
      if (typeVal.value === "my") {
        store.commit("setFootStatus", 3);
        common_vendor.index.navigateBack({
          delta: 1
        });
      } else if (typeVal.value === "family") {
        store.commit("setFootStatus", 1);
        common_vendor.index.reLaunch({
          url: `/pages/family/index`
        });
      } else if (store.state.footStatus === 2 || store.state.footStatus === 3) {
        common_vendor.index.reLaunch({
          url: `/pages/my/index`
        });
        store.commit("setFootStatus", 3);
      } else {
        store.commit("setFootStatus", 0);
        common_vendor.index.reLaunch({
          url: `/pages/index/index`
        });
      }
    };
    const handleFamily = (type) => {
      if (orderName.value === "全部") {
        params.elderId = "";
        formData.value.elderId = -1;
      }
      familyPopup.value.popup.open(type);
      getElderList();
    };
    const handleToRefresh = () => {
      params.value.pageNum = 1;
      getNewData();
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          title: "我的账单",
          isShowBack: true,
          handleToLink
        }),
        b: netStatus.value
      }, netStatus.value ? {
        c: common_vendor.sr(list, "047f72df-1", {
          "k": "list"
        }),
        d: common_vendor.o(handleFamily),
        e: common_vendor.o(setTabIndex),
        f: common_vendor.o(setElderId),
        g: common_vendor.o(_ctx.handleDelete),
        h: common_vendor.o(onReachBottom),
        i: common_vendor.p({
          itemData: itemData.value,
          orderName: orderName.value,
          moreStatus: moreStatus.value,
          loading: loading.value
        })
      } : {
        j: common_vendor.p({
          handleToRefresh
        })
      }, {
        k: common_vendor.sr(familyPopup, "047f72df-3", {
          "k": "familyPopup"
        }),
        l: common_vendor.o(setElderId),
        m: common_vendor.p({
          serviceVal: billVal.value,
          formData: formData.value,
          allElderData: itemNameData.value
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-047f72df"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/subPages/bill/index.vue"]]);
wx.createPage(MiniProgramPage);
