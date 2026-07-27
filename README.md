# 🚗 购车预算表

> 华为智能生活馆 · 广州美林天地 — 购车预算计算工具

<p align="center">
  <img src="HIMA.png" alt="HIMA Logo" width="120">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/status-active-success" alt="Status">
  <img src="https://img.shields.io/badge/license-private-red" alt="License">
  <img src="https://img.shields.io/badge/tech-vanilla%20JS-yellow" alt="Tech">
  <img src="https://img.shields.io/badge/backend-Supabase-3ecf8e" alt="Supabase">
</p>

---
![Uploading 屏幕截图 2026-07-27 123627.png…]()

## 📖 简介

一个面向汽车销售场景的**单页 Web 应用**，帮助华为智能生活馆的销售顾问快速为客户估算购车总费用和金融方案。无需后端服务器，纯静态部署，数据存储在 Supabase 云数据库中。

---

## ✨ 功能

### 🧮 落地价计算
输入裸车价后自动汇总以下费用：

| 费用项 | 说明 |
|--------|------|
| 高阶智驾包 | 可自定义金额（默认 ¥12,000） |
| 购置税 | 含新能源减免政策，自动计算 |
| 保险预估 | ¥5,000 ~ ¥15,000 分档选择 |
| 上牌服务费 | 0 / 130 / 600 元可选 |
| 其他费用 | 名称和金额均可自定义 |

### 💰 金融方案
支持 1~5 年贷款方案计算：

| 指标 | 说明 |
|------|------|
| 月供 | 等额本息，精确到分 |
| 前期支付 | 落地价 − 贷款额 |
| 车辆首付 | 裸车价 − 贷款额 |
| 总利息 / 年均利息 | 按年费率计算 |
| 年化费率 | 可自定义（默认 2.49%） |

### 🔐 密码保护
- 访问页面需验证密码
- 支持在线修改密码（需权限密码）
- 密码云端（Supabase）+ 本地（localStorage）双重存储，容灾保障

### 📊 使用统计
- 右下角实时显示当日 / 当月使用次数
- 数据同步到 Supabase，跨设备汇总

---

## 🏗 技术栈

| 层面 | 技术 |
|------|------|
| 前端 | HTML5 + CSS3 + Vanilla JavaScript（零框架依赖） |
| 后端服务 | [Supabase](https://supabase.com)（PostgreSQL + REST API） |
| CDN | Supabase JS SDK v2（jsdelivr） |
| 字体 | Inter + PingFang SC / Microsoft YaHei |
| 部署 | 纯静态，支持 GitHub Pages / Vercel / Netlify / 任意静态托管 |

---

## 📁 项目结构

```
luodijia/
├── index.html          # 主应用（前端 UI + 全部业务逻辑）
├── schema.sql           # 数据库建表脚本（config + usage_logs）
├── fix_policies.sql     # RLS 策略修复脚本（按需执行）
├── HIMA.png             # Logo 图标
├── bg.jpg               # 背景图片
└── README.md
```

---

## 🚀 快速部署

### 前置要求

- 一个 [Supabase](https://supabase.com) 账号（免费套餐即可）
- 任意静态文件托管服务（GitHub Pages / Vercel / Netlify 等）

### 步骤

#### 1. 创建 Supabase 项目

1. 登录 [supabase.com](https://supabase.com)，创建新项目
2. 进入 **Settings → API**，复制以下两个值：
   - `Project URL`
   - `anon public key`

#### 2. 初始化数据库

在 Supabase 的 **SQL Editor** 中执行 [`schema.sql`](schema.sql)：

- 创建 `config` 表（存储密码）
- 创建 `usage_logs` 表（存储使用统计）
- 配置 RLS（Row Level Security）策略

> 💡 如果遇到权限问题，再执行 [`fix_policies.sql`](fix_policies.sql) 修复 RLS 策略。

#### 3. 配置连接信息

编辑 `index.html` 第 401-402 行，替换为你的 Supabase 信息：

```javascript
const SUPABASE_URL = 'https://你的项目ID.supabase.co';
const SUPABASE_KEY = '你的anon key';
```

#### 4. 部署前端

将以下文件上传到任意静态托管服务：
- `index.html`
- `HIMA.png`
- `bg.jpg`

或直接在本地浏览器打开 `index.html` 即可使用。

---

## 🔑 默认密码

| 用途 | 默认值 | 说明 |
|------|--------|------|
| 登录密码 | `123456` | 访问页面时使用 |
| 权限密码 | `admin888` | 修改登录密码时使用 |

> ⚠️ **安全提示**：部署后请尽快在登录页面点击"修改密码"更换默认密码。

---

## 📐 购置税计算规则

| 裸车价范围 | 计算公式 |
|-----------|---------|
| < ¥339,000 | `车价 ÷ 11.3 ÷ 2`（新能源减免政策） |
| ≥ ¥339,000 | `车价 ÷ 11.3 − 15,000` |

---

## 🖥 响应式设计

| 设备 | 布局 |
|------|------|
| 手机（竖屏） | 单列堆叠，全宽展示 |
| 平板 / 桌面（横屏） | 左右双栏：费用明细 + 金融方案 |
| 大屏（>780px） | 居中卡片式，最大宽度 580px |

---

## ⚠️ 免责声明

- 购置税、保险、上牌费为测算值，具体标准以相关机构政策公示为准
- 金融方案为预估测算，具体还款信息请在办理时详询金融机构
- 本工具仅供内部使用，不构成任何购买或金融建议

---

## 📄 License

Private — 华为智能生活馆内部工具
