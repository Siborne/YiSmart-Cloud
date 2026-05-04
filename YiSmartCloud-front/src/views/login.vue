<template>
  <div class="login-page">
    <div class="login-backdrop" aria-hidden="true" />
    <div class="login-card">
      <header class="login-header">
        <p class="login-kicker">颐智云</p>
        <h1 class="login-title">{{ title }}</h1>
        <p class="login-sub">安全登录，守护长者服务数据</p>
      </header>
      <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form" size="large">
        <el-form-item prop="username">
          <el-input
            v-model="loginForm.username"
            type="text"
            auto-complete="off"
            placeholder="账号"
            class="login-input"
          >
            <template #prefix>
              <svg-icon icon-class="user" class="input-icon" />
            </template>
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            auto-complete="off"
            placeholder="密码"
            class="login-input"
            show-password
            @keyup.enter="handleLogin"
          >
            <template #prefix>
              <svg-icon icon-class="password" class="input-icon" />
            </template>
          </el-input>
        </el-form-item>
        <el-form-item v-if="captchaEnabled" prop="code" class="login-code-row">
          <el-input
            v-model="loginForm.code"
            auto-complete="off"
            placeholder="验证码"
            class="login-input login-code-input"
            @keyup.enter="handleLogin"
          >
            <template #prefix>
              <svg-icon icon-class="validCode" class="input-icon" />
            </template>
          </el-input>
          <div class="login-code-img-wrap" @click="getCode">
            <img :src="codeUrl" alt="验证码" class="login-code-img" />
          </div>
        </el-form-item>
        <div class="login-options">
          <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
        </div>
        <el-form-item class="login-submit-item">
          <el-button
            :loading="loading"
            type="primary"
            class="login-btn"
            @click.prevent="handleLogin"
          >
            <span v-if="!loading">登 录</span>
            <span v-else>登录中…</span>
          </el-button>
          <div v-if="register" class="login-register-below">
            <router-link class="login-register" :to="'/register'">立即注册</router-link>
          </div>
        </el-form-item>
      </el-form>
    </div>
    <footer class="login-footer">
      <span>Copyright © 2018-2026 颐智云 · 基于 RuoYi 框架</span>
    </footer>
  </div>
</template>

<script setup>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from "@/utils/jsencrypt"
import useUserStore from '@/store/modules/user'

const title = import.meta.env.VITE_APP_TITLE
const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

const loginForm = ref({
  username: "admin",
  password: "admin123",
  rememberMe: false,
  code: "",
  uuid: ""
})

const loginRules = {
  username: [{ required: true, trigger: "blur", message: "请输入您的账号" }],
  password: [{ required: true, trigger: "blur", message: "请输入您的密码" }],
  code: [{ required: true, trigger: "change", message: "请输入验证码" }]
}

const codeUrl = ref("")
const loading = ref(false)
const captchaEnabled = ref(true)
const register = ref(false)
const redirect = ref(undefined)

watch(route, (newRoute) => {
  redirect.value = newRoute.query && newRoute.query.redirect
}, { immediate: true })

function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (valid) {
      loading.value = true
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, { expires: 30 })
        Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 })
        Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 })
      } else {
        Cookies.remove("username")
        Cookies.remove("password")
        Cookies.remove("rememberMe")
      }
      userStore.login(loginForm.value).then(() => {
        const query = route.query
        const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
          if (cur !== "redirect") {
            acc[cur] = query[cur]
          }
          return acc
        }, {})
        router.push({ path: redirect.value || "/", query: otherQueryParams })
      }).catch(() => {
        loading.value = false
        if (captchaEnabled.value) {
          getCode()
        }
      })
    }
  })
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img
      loginForm.value.uuid = res.uuid
    }
  })
}

function getCookie() {
  const username = Cookies.get("username")
  const password = Cookies.get("password")
  const rememberMe = Cookies.get("rememberMe")
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
  }
}

getCode()
getCookie()
</script>

<style lang="scss" scoped>
.login-page {
  position: relative;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 32px 20px 72px;
  background: #0f172a url("@/assets/images/login-background.jpg") center / cover no-repeat;
  box-sizing: border-box;
}

.login-backdrop {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    125deg,
    rgba(15, 23, 42, 0.82) 0%,
    rgba(15, 23, 42, 0.55) 42%,
    rgba(0, 184, 160, 0.18) 100%
  );
  pointer-events: none;
}

.login-card {
  position: relative;
  z-index: 1;
  width: 100%;
  max-width: 420px;
  padding: 36px 36px 28px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.94);
  border: 1px solid rgba(255, 255, 255, 0.65);
  box-shadow:
    0 4px 24px rgba(15, 23, 42, 0.12),
    0 24px 64px rgba(15, 23, 42, 0.18);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
}

.login-header {
  text-align: center;
  margin-bottom: 28px;
}

.login-kicker {
  margin: 0 0 6px;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.28em;
  text-transform: uppercase;
  color: #00b8a0;
}

.login-title {
  margin: 0 0 8px;
  font-size: 22px;
  font-weight: 700;
  color: #0f172a;
  line-height: 1.35;
}

.login-sub {
  margin: 0;
  font-size: 13px;
  color: #64748b;
}

.login-form {
  :deep(.el-form-item) {
    margin-bottom: 20px;
  }

  :deep(.el-form-item__error) {
    padding-top: 4px;
  }
}

.login-input {
  :deep(.el-input__wrapper) {
    border-radius: 10px;
    box-shadow: 0 0 0 1px #e2e8f0 inset;
    transition: box-shadow 0.2s ease;
  }

  :deep(.el-input__wrapper:hover) {
    box-shadow: 0 0 0 1px #cbd5e1 inset;
  }

  :deep(.el-input__wrapper.is-focus) {
    box-shadow: 0 0 0 1px #00b8a0 inset, 0 0 0 3px rgba(0, 184, 160, 0.15);
  }
}

.input-icon {
  width: 16px;
  height: 16px;
  color: #94a3b8;
}

.login-code-row {
  :deep(.el-form-item__content) {
    display: flex;
    align-items: stretch;
    gap: 12px;
    flex-wrap: nowrap;
  }
}

.login-code-input {
  flex: 1;
  min-width: 0;
}

.login-code-img-wrap {
  flex: 0 0 auto;
  width: 118px;
  height: 40px;
  border-radius: 10px;
  overflow: hidden;
  cursor: pointer;
  border: 1px solid #e2e8f0;
  background: #f8fafc;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;

  &:hover {
    border-color: #00b8a0;
    box-shadow: 0 0 0 2px rgba(0, 184, 160, 0.12);
  }
}

.login-code-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.login-options {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: -4px 0 20px;
}

.login-register-below {
  margin-top: 14px;
  text-align: right;
}

.login-register {
  font-size: 14px;
  color: #00b8a0;
  font-weight: 500;
}

.login-submit-item {
  margin-bottom: 0 !important;

  :deep(.el-form-item__content) {
    display: block;
  }
}

.login-btn {
  width: 100%;
  height: 44px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 10px;
}

.login-footer {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 2;
  padding: 14px 16px;
  text-align: center;
  font-size: 12px;
  color: rgba(248, 250, 252, 0.88);
  text-shadow: 0 1px 2px rgba(15, 23, 42, 0.75);
  letter-spacing: 0.02em;
  background: linear-gradient(to top, rgba(15, 23, 42, 0.5), transparent);
  pointer-events: none;
}
</style>
