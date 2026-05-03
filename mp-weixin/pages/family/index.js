"use strict";
const common_vendor = require("../../common/vendor.js");
const utils_index = require("../../utils/index.js");
const pages_api_family = require("../api/family.js");
require("../../utils/request.js");
require("../../utils/env.js");
if (!Array) {
  const _component_NavBar = common_vendor.resolveComponent("NavBar");
  const _component_net_fail = common_vendor.resolveComponent("net-fail");
  const _component_UniFooter = common_vendor.resolveComponent("UniFooter");
  (_component_NavBar + _component_net_fail + _component_UniFooter)();
}
if (!Math) {
  (List + UnbindPopup)();
}
const UnbindPopup = () => "../../components/Operate/index.js";
const List = () => "./components/List.js";
const _sfc_main = {
  __name: "index",
  setup(__props) {
    const operate = common_vendor.ref(null);
    const itemData = common_vendor.ref([]);
    const moreStatus = common_vendor.ref("more");
    const oldManId = common_vendor.ref();
    const netStatus = common_vendor.ref(true);
    const loading = common_vendor.ref(false);
    const errorTipText = common_vendor.ref({
      text: "您确定要解除绑定吗？"
    });
    let params = common_vendor.reactive({
      pageNum: 1,
      pageSize: 10
    });
    const pageNum = common_vendor.ref(1);
    const pages = common_vendor.ref(0);
    const isSendRequest = common_vendor.ref(false);
    const capsuleBottom = common_vendor.ref();
    common_vendor.onLoad(() => {
      common_vendor.index.getSystemInfo({
        success: () => {
          capsuleBottom.value = common_vendor.index.getMenuButtonBoundingClientRect().bottom + 18;
        }
      });
    });
    common_vendor.onShow(() => {
      itemData.value = [];
      getNewData();
    });
    const getNewData = async () => {
      params = {
        ...params,
        pageNum: pageNum.value
      };
      if (isSendRequest.value) {
        return;
      }
      moreStatus.value = "loading";
      loading.value = false;
      await pages_api_family.getElderList(params).then((res) => {
        if (res.code === 200) {
          const {
            data
          } = res;
          const items = data == null ? [] : data;
          moreStatus.value = items.length < 10 ? "no-more" : "more";
          params.page == 1 ? itemData.value = void 0 : null;
          itemData.value = itemData.value ? [...itemData.value, ...items] : items;
          pages.value = Number(data.pages);
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
    const handleToRefresh = () => {
      params.value.pageNum = 1;
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
    const subUnbind = async () => {
      await pages_api_family.elderdeleteById(oldManId.value).then((res) => {
        if (res.code === 200) {
          utils_index.tostTip("解绑成功");
          setTimeout(() => {
            operate.value.popup.close();
            params.page = 1;
            getNewData();
            clearTimeout();
          }, 1e3);
        }
      });
    };
    const handleUnbind = (id) => {
      oldManId.value = id;
      operate.value.popup.open();
    };
    const handleBinding = () => {
      common_vendor.index.navigateTo({
        url: "/pages/family/binding"
      });
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          title: "我的家人",
          isShowBack: false
        }),
        b: netStatus.value
      }, netStatus.value ? common_vendor.e({
        c: common_vendor.o(_ctx.setTabIndex),
        d: common_vendor.o(handleUnbind),
        e: common_vendor.o(onReachBottom),
        f: common_vendor.p({
          itemData: itemData.value,
          moreStatus: moreStatus.value,
          loading: loading.value
        }),
        g: loading.value
      }, loading.value ? {
        h: common_vendor.o(handleBinding)
      } : {}, {
        i: capsuleBottom.value + "px"
      }) : {
        j: common_vendor.p({
          handleToRefresh
        })
      }, {
        k: common_vendor.sr(operate, "cd2220b8-3", {
          "k": "operate"
        }),
        l: common_vendor.o(subUnbind),
        m: common_vendor.p({
          errorTipText: errorTipText.value
        }),
        n: common_vendor.p({
          pagePath: "pages/family/index"
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-cd2220b8"], ["__file", "D:/project/2024/project-zhyl-xcx-uniapp-java-hongbo-v2.0/project-zhyl-xcx-uniapp-java2.0/pages/family/index.vue"]]);
wx.createPage(MiniProgramPage);
